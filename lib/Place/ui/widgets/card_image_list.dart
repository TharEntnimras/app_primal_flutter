

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:practica_1/Place/model/place.dart';
import 'package:practica_1/User/bloc/bloc_user.dart';
import 'package:practica_1/User/model/user.dart';
import 'card_image.dart';

class CardImageList extends StatefulWidget {
  User user;
  

  CardImageList(this.user);

  @override
  State<StatefulWidget> createState(){
    return _CardImageList();
  }

}

class _CardImageList extends State<CardImageList> {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of(context);
    return Container(
      height: 350.0,
      child: StreamBuilder(
        stream: userBloc.placesStream,
        builder: (context, snapshot){
            switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              return listViewPlaces(userBloc.buildPlaces(snapshot.data.docs, widget.user));
            case ConnectionState.active:
              return listViewPlaces(userBloc.buildPlaces(snapshot.data.docs, widget.user));
            case ConnectionState.none:
              return CircularProgressIndicator();
            default:
            return listViewPlaces(userBloc.buildPlaces(snapshot.data.docs, widget.user));
            }
        }
        )
        
    
    );
  }

  /*Widget listViewPlaces(List<CardImageWithFabIcon> placesCard){
    return ListView( 
        padding: EdgeInsets.all(25.0),
        scrollDirection: Axis.horizontal,
        children: placesCard,
      );
  }*/

  Widget listViewPlaces(List places){

    void setLiked(Place place){
    setState(() {
        place.liked=!place.liked;
        userBloc.likePlace(place, widget.user.uid);
        place.likes = place.liked?place.likes+1:place.likes-1;
        userBloc.placeSelectedSink.add(place);
    });
  }
    IconData iconDataLiked = Icons.favorite;
    IconData iconDataLike = Icons.favorite_border;
     
    return ListView(
      padding: EdgeInsets.all(25.0),
      scrollDirection: Axis.horizontal,
      children: places.map((place){ 
         //places.map(place) tomamos un objeto a la vez de la lista y procesamos
        return GestureDetector(
          onTap: (){
            print("CLICK EN EL LUGAR: ${place.name}");
            userBloc.placeSelectedSink.add(place);
          },
          child: CardImageWithFabIcon(
          pathImage: place.urlImage,
          width: 300.0,
          height: 250.0,
          left: 20.0,
          internet: true,
          iconData: place.liked? iconDataLiked:iconDataLike,
          onPressedFabIcon: (){
            
            setLiked(place);
          },
          
          //internet: true,
        )
        );
     }).toList(),
);

}

}

 
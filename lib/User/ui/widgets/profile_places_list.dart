

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:practica_1/Place/model/place.dart';
import 'package:practica_1/User/bloc/bloc_user.dart';
import 'package:practica_1/User/model/user.dart';
import 'package:practica_1/User/ui/widgets/profile_place.dart';


class ProfilePlacesList extends StatelessWidget {

  UserBloc userBloc;
  User  user;
  ProfilePlacesList(this.user);
  

   Place place = Place(
    name: "Knuckles Mountains Range",
    description: "Hiking. Water fall hunting. Natural bath bitch",
    urlImage: "https://twogetlost.com/wp-content/uploads/2018/11/WhatsApp-Image-2018-11-18-at-20.19.16-1024x636.jpeg",
    likes: 3
  );
  Place place2 = Place(
    name: "Mountains",
    description: "Hiking. Water fall hunting. Natural bath', 'Scenery & Photography",
    urlImage: "https://uiaa-web.azureedge.net/wp-content/uploads/2017/11/RTM19-banner-web.jpg",
    likes: 10
  );

  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of(context);
    return Container(
      margin: EdgeInsets.only(
          top: 10.0,
          left: 20.0,
          right: 20.0,
          bottom: 10.0
      ),
      child: StreamBuilder(
        stream: userBloc.myPlacesListStream(user.uid),
        builder:(context, AsyncSnapshot snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.waiting :
              return CircularProgressIndicator();
            case ConnectionState.done:    
              return Column(
                children: userBloc.buildMyPlaces(snapshot.data.docs) ,
              );
            case ConnectionState.active: 
              return Column(
                children: userBloc.buildMyPlaces(snapshot.data.docs) ,
              );
            case ConnectionState.none:
              return CircularProgressIndicator();
              
            default: return Column(
                children: userBloc.buildMyPlaces(snapshot.data.docs) ,
              );
          }

        }

        

        )
    );
  }

 
} 
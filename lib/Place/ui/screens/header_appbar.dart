import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:practica_1/Place/ui/widgets/card_image_list.dart';
import 'package:practica_1/User/bloc/bloc_user.dart';
import 'package:practica_1/User/model/user.dart';
import '../../../widgets/gradient_back.dart';


class HeaderAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserBloc userBloc;
    userBloc = BlocProvider.of(context);

    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator(),);
          case ConnectionState.none:
            return Center(child: CircularProgressIndicator(),);
          case ConnectionState.active:
            return showPlacesData(snapshot);
          case ConnectionState.done:
            return showPlacesData(snapshot);
          default:
            return showPlacesData(snapshot);
        }
      },
    );
  }

  Widget showPlacesData(AsyncSnapshot snapshot){
  if(!snapshot.hasData || snapshot.hasError){
    return Stack(
      children: [
        GradientBack(height: 250.0),
        Text("Usuario no logueado. Logueate")
      ],
      );
  } else {
    User user = User(
      uid: snapshot.data.uid,
      name: snapshot.data.displayName,
      email: snapshot.data.email,
      photoURL: snapshot.data.photoURL
      );

      return Stack(
        children: [
          GradientBack(height: 250.0),
          CardImageList(user)
        ],
      );
  }

  }



}
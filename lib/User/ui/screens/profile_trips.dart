import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:practica_1/User/bloc/bloc_user.dart';
import 'package:practica_1/User/model/user.dart' as us;
import 'package:practica_1/User/ui/screens/profile_header.dart';
import 'package:practica_1/User/ui/widgets/profile_background.dart';
import 'package:practica_1/User/ui/widgets/profile_places_list.dart';

class ProfileTrips extends StatelessWidget {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);

    return StreamBuilder(
        stream: userBloc.authStatus,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              return showProfileData(snapshot);
            case ConnectionState.active:
              return showProfileData(snapshot);
            case ConnectionState.none:
              return CircularProgressIndicator();
            default:
            return showProfileData(snapshot);
          }
        });
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      print("NO ESTAS LOGUEADO PRRO");
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[Text("Usuario no logueado PAPU")],
          ),
        ],
      );
    } else {
      print("LOGUEADO PAPURRI WREY");
      var user = us.User(
          uid: snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoURL);
      return Stack(
        children:[
          ProfileBackground(),
          ListView(
            children: [ProfileHeader(user), ProfilePlacesList(user)],
          ),
        ],
      );
    }
  }
}

/*Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[
            ProfileHeader(user),
            ProfilePlacesList(user)

          ],
        ),
      ],
    );*/

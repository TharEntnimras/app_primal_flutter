import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:practica_1/User/bloc/bloc_user.dart';
import 'package:practica_1/User/model/user.dart' as Userm;
import 'package:practica_1/User/ui/widgets/button_bar.dart';
import 'package:practica_1/User/ui/widgets/user_info.dart' as us;

class ProfileHeader extends StatelessWidget {
  UserBloc userBloc;
  Userm.User user;

  ProfileHeader(@required this.user);

  @override
  Widget build(BuildContext context) {

    final title = Text(
      'Perfil Viajero',
      style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0),
    );

    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[title],
          ),
          us.UserInfo(user),
          ButtonsBar()
        ],
      ),
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      print("No logueado PAPU");
      return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("No se pudo cargar la informacion. Loguea PAPU")
          ],
        ),
      );
    } else {
      print("Logueado papu");
      print(snapshot.data);
      user = Userm.User(
          uid: snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoURL);
      final title = Text(
        'Profile',
        style: TextStyle(
            fontFamily: 'Lato',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0),
      );

      return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[title],
            ),
            us.UserInfo(user),
            ButtonsBar()
          ],
        ),
      );
    }
  }
}

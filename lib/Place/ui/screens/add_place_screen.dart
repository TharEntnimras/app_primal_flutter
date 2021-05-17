import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'package:practica_1/Place/model/place.dart';
import 'package:practica_1/Place/ui/widgets/card_image.dart';
import 'package:practica_1/Place/ui/widgets/title_input_location.dart';
import 'package:practica_1/User/bloc/bloc_user.dart';
import 'package:practica_1/widgets/button_purple.dart';
import 'package:practica_1/widgets/gradient_back.dart';
import 'package:practica_1/widgets/text_input.dart';
import 'package:practica_1/widgets/title_header.dart';

class AddPlaceScreen extends StatefulWidget {
  File image;
  User user;

  AddPlaceScreen({Key key, this.image});

  @override
  _AddPlaceScreen createState() => _AddPlaceScreen();
}

class _AddPlaceScreen extends State<AddPlaceScreen> {

  var _controllerTitlePlace = TextEditingController();
  var _controllerLocalizationPlace = TextEditingController();
  var _controllerDescriptionPlace = TextEditingController();
  @override
  Widget build(BuildContext context) {

    
    UserBloc userBloc = BlocProvider.of(context); // no le puse <userbloc>
    return Scaffold(
      body: Stack(
        children: [
          GradientBack(height: 300.0),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 25.0, left: 1.0),
                child: SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: IconButton(
                      icon: Icon(Icons.arrow_left),
                      color: Colors.white,
                      iconSize: 45.0,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ),
              Flexible(
                  child: Container(
                padding: EdgeInsets.only(
                    top: 45.0, bottom: 10, left: 18.0, right: 10.0),
                child: TitleHeader(title: "Agrega nuevo lugar"),
              ))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 100.0, bottom: 30.0),
            child: ListView(
              children: [
                Container(
                  //imagen del nuevo lugar
                  alignment: Alignment.center,
                  child: CardImageWithFabIcon(
                    imagefile: widget.image,
                    iconData: Icons.camera_alt,
                    width: 310.0,
                    height: 250.0,
                    left: 0,
                    onPressedFabIcon: (){},
                    internet: false,
                  ),
                ),
                Container(
                  // ctitulo del nuev9 lugar
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextInput(
                    hintText: "Lugar",
                    inputType: null,
                    maxlines: 1,
                    controller: _controllerTitlePlace,
                  ),
                ),
                TextInput(
                  //descripcion del nuevo lugar
                  hintText: "Descripcion",
                  controller: _controllerDescriptionPlace,
                  maxlines: 4,
                  inputType: TextInputType.multiline,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextInputLocation(
                    hintText: "Añade localizacion",
                    iconData: Icons.location_on,
                    controller: _controllerLocalizationPlace,

                  ),
                ),
                Container(
                  width: 70.0,
                  child: ButtonPurple(
                      buttonText: "Añadir lugar",
                      onPressed: () {
                        // ID del usuario logueado actualmente
                        widget.user = userBloc.getcurrentUser();
                        if (widget.user != null) {
                          Navigator.pop(context);
                          String uid = widget.user.uid;
                          String path = "$uid/${DateTime.now().toString()}.jpg";
                          // 1.firebase storage
                          // //url -
                          userBloc
                              .uploadFile(path, widget.image)
                              .then((UploadTask storageUploadTask) {
                            storageUploadTask.then((TaskSnapshot snapshot) {
                              snapshot.ref.getDownloadURL().then((urlImage) {
                                print("URL IMAGE: $urlImage");

                                // 2. cloud firestore
                                // place - title, description, url, userowner, likes
                                userBloc
                                    .updatePlaceData(Place(
                                  name: _controllerTitlePlace.text,
                                  description: _controllerDescriptionPlace.text,
                                  urlImage: urlImage,
                                  likes: 0,
                                  liked: false
                                ))
                                    .whenComplete(() {
                                  print("TERMINO LA SUBIDA DEL LUGAR PAPU");
                                  
                                });
                              });
                            });
                          });
                        }
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

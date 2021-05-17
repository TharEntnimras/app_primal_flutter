import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practica_1/widgets/floating_action_button_green.dart';

class  CardImageWithFabIcon extends StatelessWidget {

  final double height;
  final double width;
  double left;
  String pathImage;
  VoidCallback onPressedFabIcon;
  final IconData iconData;
  File imagefile;
  bool internet = true;





  CardImageWithFabIcon({Key key, 
  this.pathImage,
  @required this.width,
  @required this.height,
  @required this.onPressedFabIcon,
  @required this.iconData,
  this.left,
  this.imagefile,
  this.internet

  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final card = Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(
        top: 20.0,
        left: left

      ),

      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: internet?CachedNetworkImageProvider(pathImage):FileImage(imagefile)//pathImage==null? FileImage(imagefile): NetworkImage(pathImage),          //AssetImage(pathImage) 
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        boxShadow: <BoxShadow>[
          BoxShadow (
            color:  Colors.black38,
            blurRadius: 15.0,
            offset: Offset(0.0, 7.0)
          )
        ]

      ),
    );

    return Stack(
      alignment: Alignment(0.9,1.1),
      children: <Widget>[
        card,
        FloatingActionButtonGreen(iconData: iconData, onPressed: onPressedFabIcon,)
      ],
    );
  }

}
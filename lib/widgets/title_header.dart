import 'dart:ui';

import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  final String title;
  
  TitleHeader({Key key, @required this.title});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    return 
      Container(
        width: screenWidth,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontFamily: "Lato",
            fontWeight: FontWeight.bold
          ),
        ),

        
        ); 
      
  }
}
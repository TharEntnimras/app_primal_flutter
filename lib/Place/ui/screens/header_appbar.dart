import 'package:flutter/material.dart';
import 'package:practica_1/Place/ui/widgets/card_image_list.dart';
import '../../../widgets/gradient_back.dart';


class HeaderAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        GradientBack("Bienvenido"),
        CardImageList()
      ],
    );
  }

}
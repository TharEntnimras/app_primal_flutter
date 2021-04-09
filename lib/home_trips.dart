import 'package:flutter/material.dart';
import 'package:practica_1/review_list.dart';
import 'description_place.dart';
import 'header_appbar.dart';

class HomeTrips extends StatelessWidget {
  
String dummy =
      "Helena Blavatsky, Helena Blavatsky, también conocida como Madame Blavatsky, (Yekaterinoslav, 12 de agosto de 1831-Londres, 8 de mayo de 1891), fue una escritora, ocultista y teósofa rusa. Su nombre de soltera era Helena von Hahn, y tras un breve matrimonio con Nikiphor Blavatsky adoptó el nombre Helena Petrovna Blavatskaya —Елена Петровна Блаватская, en ruso- que una de las fundadoras de la Sociedad Teosófica y contribuyó a la difusión de la teosofía. Sus libros más importantes son Isis sin velo y La Doctrina Secreta, escritos en 1875 y 1888.";
  @override
  Widget build(BuildContext context) {
    return Stack(
            children: [
              ListView(
                children: [
                  DescriptionPlace("Bahamas", 4, dummy),
                  ReviewList()
                ],
              ),
              HeaderAppBar(),
            ],
          );
  }
}
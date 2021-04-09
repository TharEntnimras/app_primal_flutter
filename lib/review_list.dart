import 'package:flutter/material.dart';
import 'review.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Review("assets/img/bolvar.png", "Bolvar Fordragon", "WTF who is this whore in MY DOMAIN!!", "123 reviews 1 Photo"),
        Review("assets/img/yelmo.png", "Crown of Domination", "OMG im so fucked right now, wield meeee!!!", "3 reviews 12345 Photos"),
        Review("assets/img/corona.png","Silvanas Windrunner","This crown is so lazy, i will break it!", "1 review 5 photos"),
      ],
    );
  }
}
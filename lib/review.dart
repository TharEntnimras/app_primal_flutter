import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  String pathimage = "assets/img/corona.png";
  String name = "Silvanas Windrunner";
  String details = "1 review 5 photos";
  String comment = "This crown is so lazy, i will break it!";
  Review(this.pathimage, this.name,this.comment,this.details);
  @override
  Widget build(BuildContext context) {

      final star = Container(
      margin: EdgeInsets.only(
        top: 323.0,
        right: 3.0,
      ),
      child: Icon(
        Icons.star,
        color: Color(0xFFf2C611),
      ),
    );
    final star_half = Container(
      margin: EdgeInsets.only(
        top: 323.0,
        right: 3.0,
      ),
      child: Icon(
        Icons.star_half,
        color: Color(0xFFf2C611),
      ),
    );
    final star_border = Container(
      margin: EdgeInsets.only(
        top: 323.0,
        right: 3.0,
      ),
      child: Icon(
        Icons.star_border,
        color: Color(0xFFf2C611),
      ),
    );

     

    final userComment = Container(
      margin: EdgeInsets.only(
        left: 20.0,
      ),
      child: Text(
         comment,
         overflow: TextOverflow.fade,
         maxLines: 1,
         softWrap: false,
         textAlign: TextAlign.left,
         style: TextStyle(
           fontFamily: "Lato",
           fontSize: 12.0,
         ),
      ),

    );

    final userInfo = Container(
      margin: EdgeInsets.only(
        left: 20.0,
      ),
      child: Text(
         details,
         textAlign: TextAlign.left,
         style: TextStyle(
           fontFamily: "Lato",
           fontSize: 12.0,
           fontWeight: FontWeight.w900,
           color: Color(0xFFa3a5a7)
         ),
      ),

    );

    final userName = Container(
      margin: EdgeInsets.only(
        left: 20.0,
      ),
      child: Text(
         name,
         textAlign: TextAlign.left,
         style: TextStyle(
           fontFamily: "Lato",
           fontSize: 13.0,
         ),
      ),

    );

    final userdetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        userName,
        userInfo,
        userComment

      ],
    );

    final photo = Container(
      margin: EdgeInsets.only(
        top: 20.0,
        left: 20.0,
      ),
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(pathimage),
          )),
    );

    return Row(
      children: [
        photo,
        userdetails
      ],
    );
  }
}

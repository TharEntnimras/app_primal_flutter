import 'package:flutter/material.dart';
import 'package:practica_1/Place/model/place.dart';

class User {

  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final List<Place> myPlaces; 
  final List<Place> myFavoritePlaces;

  User({ Key key, 
  @required this.uid,
  @required this.name,
  @required this.email,
  @required this.photoURL,
  this.myPlaces,
  this.myFavoritePlaces

  });

  //myFavoritePlaces 
  //myPlaces

  
}
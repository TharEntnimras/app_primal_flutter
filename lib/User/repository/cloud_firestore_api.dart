import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica_1/Place/model/place.dart';
import 'package:practica_1/Place/ui/widgets/card_image.dart';
import 'package:practica_1/User/model/user.dart' as u;
import 'package:practica_1/User/ui/widgets/profile_place.dart';

class CloudFirestoreAPI {

  final String USERS = "users";
  final String PLACES = "places";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserData(u.User user) async{
    DocumentReference ref = _db.collection(USERS).doc(user.uid);
    return ref.set( {
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSignIn': DateTime.now() 
    }); //merge:true
  } 
  Future<void> updatePlaceData(Place place) async {
    CollectionReference refPlaces = _db.collection(PLACES);
    var user = _auth.currentUser; 
    refPlaces.add(
      {
      'name' : place.name,
      'description' : place.description,
      'likes' : place.likes, 
      'urlImage' : place.urlImage,
      'liked': place.liked,
      'userOwner' : _db.doc("$USERS/${user.uid}"), //reference - tipo de dato referencia
      'usersLiked': FieldValue.arrayUnion([ ])
      }
    ).then((DocumentReference dr) {
      dr.get().then((DocumentSnapshot snapshot){
          snapshot.id; // ID del LUGAR  - EN UN ARRAY
          DocumentReference refUsers = _db.collection(USERS).doc(user.uid);
        
          refUsers.update({
            'myPlaces': FieldValue.arrayUnion([_db.doc("$PLACES/${snapshot.id}")])
          });

      });
    });
    
  }

   // Se encarga de procesor los datos del snapshot que se trae de Firestore 
  // y ponerlos en una lista creada aca para ser mostrada

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot){
    List<ProfilePlace> profilePlaces = List<ProfilePlace>();
    placesListSnapshot.forEach((p) {
      profilePlaces.add(ProfilePlace(
        Place( 
          name: p.get('name'),//p.data['name'],  
          description: p.get('description'), 
          urlImage: p.get('urlImage'),
          likes:  p.get('likes')
          
          )
      ));
     });

    return profilePlaces;
  }

  List<Place> buildPlaces(List<DocumentSnapshot> placesListsnapshot, u.User user){
    List<Place> places = List<Place>();
    //List usersLikedRefs;

    placesListsnapshot.forEach((p) { 
      Place place = Place(
        id: p.id ,
        name: p.get("name"),
        description: p.get('description'),
        urlImage: p.get('urlImage'),
        liked: p.get('liked'),
        likes: p.get('likes')

        );
        
        // verificacion de imagenes likeadas por el usuario
        List usersLikedRefs = p.get('usersLiked');
              place.liked = false; 
              usersLikedRefs?.forEach((drUL) {
              if(user.uid == drUL.id){
              place.liked = true;
          }
         });

            
        
      
      places.add(place);
         
    });

    return places;

  }

/*
  List<CardImageWithFabIcon> buildPlaces(List<DocumentSnapshot> placesListSnapshot ){

    List<CardImageWithFabIcon> placesCard = List<CardImageWithFabIcon>(); 
    placesListSnapshot.forEach((p) {
         double width = 300.0;
         double height = 350.0;
         double left = 20.0;
         IconData iconData = Icons.favorite_border;
       placesCard.add(CardImageWithFabIcon(
        pathImage: p.get("urlImage"),
        width: width, 
        height: height,
        left: left, 
        onPressedFabIcon: (){
          // likes 
          likePlace(p.);
          
        }, 
        iconData: iconData 
        ));
    });

    return placesCard;
  }*/

Future likePlace (Place place, String uid) async {
  await _db.collection(PLACES).doc(place.id).get()
  .then(( DocumentSnapshot ds) {
      int likes = ds.get("likes");

      _db.collection(PLACES).doc(place.id).
      update({
        'liked': place.liked,
        'likes': place.liked?likes+1:likes-1,
        'usersLiked': place.liked?
                      FieldValue.arrayUnion([_db.doc("$USERS/$uid")]):
                      FieldValue.arrayRemove([_db.doc("$USERS/$uid")])

      });  

  });

}
  
}
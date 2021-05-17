import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica_1/Place/model/place.dart';
import 'package:practica_1/Place/ui/widgets/card_image.dart';
import 'package:practica_1/User/model/user.dart';
import 'package:practica_1/User/repository/cloud_firestore_api.dart';
import 'package:practica_1/User/ui/widgets/profile_place.dart';
class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();
  void updateUserDataFirestore(User user)=> _cloudFirestoreAPI.updateUserData(user);
  Future<void> updatePlaceData(Place place) => _cloudFirestoreAPI.updatePlaceData(place);
  List<Place> buildPlaces(List<DocumentSnapshot> placesListsnapshot, User user)=> _cloudFirestoreAPI.buildPlaces(placesListsnapshot, user);
  //List<CardImageWithFabIcon> buildPlaces(List<DocumentSnapshot> placesListSnapshot ) => _cloudFirestoreAPI.buildPlaces(placesListSnapshot);
  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreAPI.buildMyPlaces(placesListSnapshot);

  Future likePlace(Place place, String uid) => _cloudFirestoreAPI.likePlace(place,uid);
}
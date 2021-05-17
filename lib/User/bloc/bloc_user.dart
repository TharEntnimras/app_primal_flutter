import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:practica_1/Place/model/place.dart';
import 'package:practica_1/Place/repository/firebase_storage_repository.dart';
import 'package:practica_1/Place/ui/widgets/card_image.dart';
import 'package:practica_1/User/repository/auth_repository.dart';
import 'package:practica_1/User/repository/cloud_firestore_api.dart';
import 'package:practica_1/User/repository/cloud_firestore_repository.dart';
import 'package:practica_1/User/model/user.dart' as u;
import 'package:practica_1/User/ui/widgets/profile_place.dart';

class UserBloc implements Bloc {

  final _auth_repository=AuthRepository();


  //FLUJO DE DATOS - stream
  //Stream - firebase 
  // Streamcontroller - se usa para definir nuestro propio flujod e datos, 
  // para definirlo o alterarlo, PERO firebase ya tiene su flujo asi que 
  // solo usaremos STREAM 
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;
  
  User getcurrentUser() => FirebaseAuth.instance.currentUser;


  //caso de uso
  ////1. sign in con google
  Future<User> signIn()=> _auth_repository.signInFireBase();

  // registrar usuario en base de datos 
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(u.User user)=> _cloudFirestoreRepository.updateUserDataFirestore(user);
   
  Future<void> updatePlaceData(Place place)=>_cloudFirestoreRepository.updatePlaceData(place);

  // escucha los cambios hechos a PLACES y actualiza automaticamente
  Stream <QuerySnapshot> placesListStream = FirebaseFirestore.instance.collection(CloudFirestoreAPI().PLACES).snapshots();
  Stream<QuerySnapshot> get placesStream => placesListStream;

  //lista de lugares - llamada y procesamiento del snapshot de firestore
  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildMyPlaces(placesListSnapshot);
  Stream<QuerySnapshot> myPlacesListStream(String uid) => 
      FirebaseFirestore.instance.collection(CloudFirestoreAPI().PLACES)
      .where("userOwner", isEqualTo: FirebaseFirestore.instance.doc('${CloudFirestoreAPI().USERS}/$uid'))
      .snapshots();
  
  Future likePlace(Place place, String uid) => _cloudFirestoreRepository.likePlace(place,uid);

  List<Place> buildPlaces(List<DocumentSnapshot> placesListsnapshot, u.User user) => _cloudFirestoreRepository.buildPlaces(placesListsnapshot, user);
 
  //List<CardImageWithFabIcon> buildPlaces(List<DocumentSnapshot> placesListSnapshot ) => _cloudFirestoreRepository.buildPlaces(placesListSnapshot);

  final _firebaseStorageRepository = FirebaseStorageRepository();

  Future<UploadTask> uploadFile(String path, File image) => _firebaseStorageRepository.uploadFile(path, image);

   // STREAM creado por nosotros para controlar el texto en el inicio de la app de los PLACES
   StreamController placeSelectedStreamController = StreamController();
   Stream get placeSelectedStream => placeSelectedStreamController.stream;
   StreamSink  get placeSelectedSink => placeSelectedStreamController.sink; 



  signOut(){
    _auth_repository.signOut(); 
  }


  @override 
  void dispose(){
    placeSelectedStreamController.close();
  }
  
}
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:practica_1/Place/repository/firebase_storage_api.dart';

class FirebaseStorageRepository {
  final _firebaseStorageAPI = FirebaseStorageAPI();

  Future<UploadTask> uploadFile(String path, File image)=>_firebaseStorageAPI.upload( path, image);


}


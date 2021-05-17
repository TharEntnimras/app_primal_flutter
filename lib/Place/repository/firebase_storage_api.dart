import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


class FirebaseStorageAPI {

  final Reference _storageReference = FirebaseStorage.instance.ref();

  Future<UploadTask> upload(String path, File image) async {

    Future storageUploadTask 
    = _storageReference.child(path).putFile(image);  
    
    return storageUploadTask;
    
    }

   
}
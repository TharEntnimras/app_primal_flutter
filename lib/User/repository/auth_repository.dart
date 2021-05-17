import 'package:firebase_auth/firebase_auth.dart';
import 'package:practica_1/User/repository/firebase_auth_api.dart';

class AuthRepository {
  final _firebaseAuthAPI = FirebaseAuthAPI();
  Future<User> signInFireBase() => _firebaseAuthAPI.signIn();

  signOut()=> _firebaseAuthAPI.signOut();

  

} 
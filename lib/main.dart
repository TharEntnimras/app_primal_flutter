import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practica_1/User/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'User/ui/screens/sign_in_screen.dart';
import 'package:practica_1/User/repository/firebase_auth_api.dart';


Future main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      auth: FirebaseAuthAPI(),
      child: MaterialApp(
      title: 'Flutter Demo',
      //home: PlatziTripsCupertino(),
      home: SignInScreen(),
    ), 
      bloc: UserBloc()
      );
  }
} 


 
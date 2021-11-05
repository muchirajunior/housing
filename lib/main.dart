import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:housing/screens/create.dart';
import 'package:housing/screens/home.dart';
import 'package:housing/screens/launcher.dart';
import 'package:housing/screens/signup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Housing',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),

      routes: {
        '/':(context)=>Launcher(),
        '/signup':(context)=>SignUp(),
        '/home':(context)=>Home(),
        '/create':(context)=>CreatePost()
      },
     
    );
  }
}

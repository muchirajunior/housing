import 'package:flutter/material.dart';
import 'package:housing/services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Launcher extends StatelessWidget {
  
  loadData(BuildContext context)async{
    await Future.delayed(Duration(seconds: 2));
    SharedPreferences preferences= await SharedPreferences.getInstance();
    if (preferences.containsKey('name')) {
      var data=await currentUser();
       Navigator.pushReplacementNamed(context, '/home', arguments: data);
    }
    else
       Navigator.pushReplacementNamed(context, '/signup');
  }

  @override
  Widget build(BuildContext context) {
    loadData(context);

    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Center(
        child: CircularProgressIndicator(color: Colors.amber, strokeWidth: 5.0,) 
        ),
        
    );
  }
}
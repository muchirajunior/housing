import 'package:flutter/material.dart';

class Launcher extends StatelessWidget {
  
  loadData(BuildContext context)async{
    await Future.delayed(Duration(seconds: 2));
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
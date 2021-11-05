import 'package:flutter/material.dart';
import 'package:housing/services/services.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOUSE POSTS'),
        actions: [
          IconButton(onPressed:()=>logOut(context),
           icon: Icon(Icons.person_remove))
        ],
      ),
      body: Center(child: CircularProgressIndicator(),),


      
    );
  }
}
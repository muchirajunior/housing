import 'package:flutter/material.dart';
import 'package:housing/screens/components.dart';

class HousePreview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var data=ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(data['house']),
      ),

      body: ListView(
        children: [
          Container(
          width: double.infinity,
          child: imageBox(data['image']) ,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(data['description']),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()=>messageBox(context, data['landlordId'], data["username"]),
        child: Icon(Icons.message_sharp),
      ),
      
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';



createuser(Map<String, dynamic> user)async{
  var res;
  SharedPreferences preferences=await SharedPreferences.getInstance();
  CollectionReference reference = FirebaseFirestore.instance.collection('users');
  await reference.add(user)
  .then((value) {
    res='success';
    preferences.clear();
    preferences.setString("name", user['name']);
    preferences.setString("username", user['username']);
    preferences.setString("type", user['type']);
    preferences.setString("id", value.id);    

  })
  .catchError((error){print(error); res='failed'; });

  return res;
}

loginUser(String username, var pass)async{
  var data;
  SharedPreferences preferences=await SharedPreferences.getInstance();
  CollectionReference reference = FirebaseFirestore.instance.collection('users');
  await reference.where("username", isEqualTo: username).get().then((value){
    if (value.docs.first.exists){
      data=value.docs.first.data() as Map;
      preferences.clear();
      preferences.setString("name", data['name']);
      preferences.setString("username", data['username']);
      preferences.setString("type", data['type']);
      preferences.setString("id", value.docs.first.id);  
    }
  });
  String results= data['password']==pass ?  "success" : "failed" ;
  return results;
}

logOut(BuildContext context)async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  await preferences.clear();
  Navigator.pushReplacementNamed(context, '/');
}
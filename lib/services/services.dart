import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:housing/services/utils.dart';
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
  try{
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
 
  String results=data['password']==pass ?  "success" : "failed" ;
  return results;
  
  }catch(error){
    return 'failed';
  }
}

logOut(BuildContext context)async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  await preferences.clear();
  Navigator.pushReplacementNamed(context, '/');
}

createNewPost(var house, var description, var image)async{
 
  var result='failed';
  try{
  CollectionReference reference= FirebaseFirestore.instance.collection('posts');
  var user=await currentUser();
  await reference.add({
      "house":house,
      "description":description,
      "landlordId":user['id'],
      'username':user['username'],
      'image':image.path.split('/').last
    }).then((value) => result='success');

  }catch(e){ print(e);}

  await uploadImage(image);

  return result;
}

uploadImage(var _imageFile)async{
  File file = File(_imageFile.path);
  var filename=_imageFile.path.split('/').last;
 FirebaseStorage  storage=FirebaseStorage.instance;

 await storage.ref('images/$filename').putFile(file);
  

}

sendMessage(var receiverId, var receiverName, var message) async{
    CollectionReference reference=FirebaseFirestore.instance.collection('messages');
    var user=await currentUser();
    await reference.add({
      "senderId":user['id'],
      "senderName":user['username'],
      "receiverId":receiverId,
      "receiverName":receiverName,
      "message":message
    }).then((v) => print("successfully sent message"));
}

deletePost(var id)async{
     CollectionReference reference= FirebaseFirestore.instance.collection('posts');

     await reference.doc(id).delete().then((value) => print("post deleted sucessfuly"));
}

deleteMessage(var id) async{
  CollectionReference reference= FirebaseFirestore.instance.collection('messages');
  await reference.doc(id).delete();
}

/*
this method is no longer in use
getImage(var name)async{
  try{
    // var url;
    FirebaseStorage storage= FirebaseStorage.instance;
   var url= await storage.ref('images/$name').getDownloadURL();
    
   print("\n printin image url $url \n");

    return url.toString();
  }catch(e){
    return "no url";
  }
}

*/
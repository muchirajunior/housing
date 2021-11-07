import 'package:flutter/material.dart';
import 'package:housing/services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Launcher extends StatelessWidget {

  var url="https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/p-397-ted8565-jir-f-job580.jpg?w=600&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=1253097170d9500c1da727b245f54f2b";
  
  loadData(BuildContext context)async{
    await Future.delayed(Duration(seconds: 4));
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
      body:  Container(
        height: double.infinity,
        width:double.infinity ,
        decoration: BoxDecoration(
          color:Colors.blue,
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)
        ),
       
       child: SafeArea(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
            SizedBox(height: 30,),
            Text("WELCOME",style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            Text(" CRIB FINDER APP ",
             style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 100,),
            CircularProgressIndicator(color: Colors.brown)
           ]
         ),
       ),
       
      ),
        
    );
  }
}
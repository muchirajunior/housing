import 'package:flutter/material.dart';
import 'package:housing/screens/components.dart';
import 'package:housing/screens/messages.dart';
import 'package:housing/screens/posts.dart';
import 'package:housing/services/services.dart';
import 'package:housing/services/utils.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

 int index=0;
 List<Widget> tabs=[
   Posts(),
   Messages()
 ];

 Map<String, dynamic> user={
   'username':"user",
   'type':"user"
 };

 getUser()async{ user= await currentUser();}

 @override
  void initState() {
    super.initState();
    getUser();
  }

 

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text('HOUSE POSTS'),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(user['username']),
              Icon(Icons.person)
            ],
          ),
          popMenu(user['type'], context)
        ],
      ),
      body: tabs[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (newIndex)=>setState((){index=newIndex;}),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "messages",
          ),
        ],
      )


      
    );
  }
}
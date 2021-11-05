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


 @override
  void initState() {
    super.initState();
    
  }

 

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(index==0 ? 'HOUSE POSTS' :"MESSAGES"),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.person),
              Text(user['username']),
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
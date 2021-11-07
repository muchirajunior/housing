import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housing/screens/components.dart';
import 'package:housing/services/utils.dart';

class Posts extends StatefulWidget {
  const Posts({ Key? key }) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  _viewHouse(){}
  
  var user;
 
  getUser() async {
    var data=await currentUser();
    setState(() {
      user=data;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context,  snapshot){
        if (snapshot.hasData){
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 250,
              childAspectRatio: 4 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10
              ), 
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              var post=snapshot.data!.docs[index];
             
                return Card(
                  child: InkWell(
                    onTap: ()=>Navigator.pushNamed(context, '/house', arguments: post.data()),
                    child: Column(
                      children: [
                        imageBox(post['image'], height:100.0),
                        
                        Text(post['house']),
                        Expanded(
                          child: Text(post['description'],style: TextStyle( color: Colors.grey,),
                                       maxLines: 3, overflow: TextOverflow.ellipsis),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          post['landlordId']== user['id'] ?  ElevatedButton(onPressed: ()=>deleteBox(context, post.id),
                           child: Text('delete')):
                           ElevatedButton(onPressed: ()=>messageBox(context, post['landlordId'], post["username"]),
                           child: Text('chat')),
                          IconButton(onPressed: (){},  icon: Icon(Icons.favorite_outline, color: Colors.amber,))
                        ],)
                  
                  
                      ],
                    ),
                  )
                );
            });
        }
        else if(snapshot.hasError){
          return Center( child: Icon(Icons.warning, size: 50,),);
        }else{
          return Center(child: CircularProgressIndicator());
        }
      }
      );
  }
}
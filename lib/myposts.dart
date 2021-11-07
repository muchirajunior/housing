import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housing/screens/components.dart';
import 'package:housing/services/utils.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({ Key? key }) : super(key: key);

  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(user['name']),
      ),

      body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').where("landlordId", isEqualTo: user['id']).snapshots(),
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
                         ElevatedButton(onPressed: ()=>deleteBox(context, post.id),
                         child: Text('delete')),
                        IconButton(onPressed: (){},  icon: Icon(Icons.edit, color: Colors.amber,))
                      ],)


                    ],
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
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.pushNamed(context, '/create'),
        child: Icon(Icons.add),
      ),
      
    );
  }
}
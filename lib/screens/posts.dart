import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housing/screens/components.dart';

class Posts extends StatefulWidget {
  const Posts({ Key? key }) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  _viewHouse(){}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context,  snapshot){
        if (snapshot.hasData){
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 210,
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
                      Image.network('https://media-cdn.tripadvisor.com/media/vr-splice-j/06/dd/04/70.jpg', fit: BoxFit.fitWidth,),
                      Text(post['house']),
                      Text(post['description'],style: TextStyle( color: Colors.grey,),
                                   maxLines: 3, overflow: TextOverflow.ellipsis),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        ElevatedButton(onPressed: (){}, child: Text('view')),
                        IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline, color: Colors.amber,))
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
      );
  }
}
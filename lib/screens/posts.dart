import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({ Key? key }) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context,  snapshot){
        if (snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              var post=snapshot.data!.docs[index];
              return Card( 
                child: ListTile(
                                  
                  title: Text(post['house']),
                  subtitle: Text(post['description'],
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined), color: Colors.amber),
                        IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline),color: Colors.amber)
                      ],
                    ),
                  )

                ),
              );
              }
          ); 
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
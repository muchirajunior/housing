import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housing/screens/components.dart';
import 'package:housing/services/utils.dart';

class Messages extends StatefulWidget {
  const Messages({ Key? key }) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  var user;
  getUser() async{
     var data = await currentUser();
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
      stream: FirebaseFirestore.instance.collection('messages').where('receiverId', isEqualTo: user['id']).snapshots(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          if (snapshot.data!.docs.length==0){
            return Center(child: Text("nobody have sent you a message"),);
          }else
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){
                    var message=snapshot.data!.docs[index];
                    return Card(
                       child: ListTile(
                         title: Text(message['senderName']),
                         subtitle: Text(message['message']),
                         leading: IconButton(onPressed: ()=>messageBox(context, message['senderId'], message['senderName']), 
                                   icon: Icon(Icons.reply),  ),
                         trailing:IconButton( onPressed: ()=>deleteMessageBox(context, message.id),
                                     icon: Icon(Icons.delete, color: Colors.red),)
                       )
                    );
                  }
                );
        }
        else if (snapshot.hasError){
           return Center(child: Icon(Icons.warning, size:80),);
           }
        else return Center(child: CircularProgressIndicator(),);
      });
  }
}
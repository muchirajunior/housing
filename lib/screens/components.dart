import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housing/services/services.dart';
import 'package:housing/services/utils.dart';

signupTabButton(var text, Function method ){
  return MaterialButton(
    onPressed:()=> method(),
    child: Text(text, style: TextStyle(fontSize: 20),),
    );
}

submitButton(var text, Function method){
  return MaterialButton(
    onPressed: ()=>method(),
    child: Text(text),
  );
}


textInput(TextEditingController controller, var hint, bool pass, {int maxlines=1}){
  return Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10)),
    child: TextFormField(
      obscureText: pass,
      controller: controller,
      maxLines: maxlines,
       decoration: InputDecoration(
         contentPadding: EdgeInsets.all(10),
         border: InputBorder.none,
         hintText: hint,
       ),
    ),
  );
}

loginContainer(TextEditingController username, TextEditingController password){
  return Column(
    children: [
      textInput(username, "username", false),
      textInput(password, "password", true)
    ],
  );
}

registerContainer(TextEditingController name, TextEditingController username, TextEditingController password, TextEditingController confirmpassword){
  return Column(
    children: [
      textInput(name, "name", false),
      textInput(username, "username", false),
      textInput(password, "password", true),
      textInput(confirmpassword, "confirm password", true),
      
    ],
  );
}

dropList(var _chosenValue, State state){

return Container(
   margin: EdgeInsets.all(10),
   width: double.infinity,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10)),

    child:   DropdownButton<String>(
    focusColor:Colors.white,
    value: _chosenValue,
    //elevation: 5,
    style: TextStyle(color: Colors.white),
    iconEnabledColor:Colors.black,
    items: <String>[
      'Android',
      'IOS',
      'Flutter',
      'Node',
      'Java',
      'Python',
      'PHP',
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value,style:TextStyle(color:Colors.black),),
      );
    }).toList(),
    hint:Text(
      "Please choose a langauage",
      style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500),
    ),
    onChanged: (String? value) {
     state.setState(() {
        _chosenValue = value;
      });
    },
  ),
);
}

alert(BuildContext context,var title, var message){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      backgroundColor: Colors.blue,
      title: Text(title),
      content: Text(message),
    );
  });

}

popMenu(String user, BuildContext context)=> PopupMenuButton<String>(
          onSelected: (item) => handlePopMenuClick(item, context),
          itemBuilder: (context) => user=='landlord' ? [
             
            PopupMenuItem<String>(value: 'new', child: Text('new posts')) ,
            PopupMenuItem<String>(value: 'posts', child: Text('My posts')),
            PopupMenuItem<String>(value: 'logout', child: Text('Logout')),
          ] : [
            PopupMenuItem<String>(value: 'liked', child: Text('Liked')),
            PopupMenuItem<String>(value: 'logout', child: Text('Logout')),
          ],
        );

handlePopMenuClick(String item, BuildContext context) async{
  switch (item) {
    case 'logout': await logOut(context);
                  break;
    case 'new': Navigator.pushNamed(context, '/create');
                  break;
    case 'posts': Navigator.pushNamed(context, '/myposts');
                  break;
    default:
  }
}


messageBox( BuildContext context, var receiverId, var username)async{
  TextEditingController controller=TextEditingController();
  await showDialog(context: context, barrierDismissible: false, builder: (context){
    return AlertDialog(
      backgroundColor: Colors.grey,
      contentPadding: EdgeInsets.all(0),
      title: Text("send message"),
      content: textInput(controller, "message", false, maxlines: 4),
      actions: [
        submitButton("cancel", ()=>Navigator.pop(context)),
        IconButton(onPressed: (){
           sendMessage(receiverId, username, controller.text);
           snackbar(context,"message sent successfuly");
           Navigator.pop(context);
        },
         icon: Icon(Icons.send, size:30))

      ],
    );
  });
}

deleteBox(BuildContext context, var id)async{
     await showDialog(context: context, barrierDismissible: false, builder: (context){
    return AlertDialog(
       title: Text("warning"),
       content: Text("once you delete this process is not reversible",
              style: TextStyle(color: Colors.red), ),
       actions: [
         submitButton("cancel", ()=>Navigator.pop(context)),
         IconButton(onPressed: (){
           deletePost(id);
           snackbar(context, "deleted post sucessfuly");
           Navigator.pop(context);},
          icon: Icon(Icons.delete, color: Colors.red,))
       ],

      );
    });
}

deleteMessageBox(BuildContext context, var id)async{
   await showDialog(context: context, barrierDismissible: false, builder: (context){
    return AlertDialog(
       title: Text("warning"),
       content: Text("once you delete this process is not reversible",
              style: TextStyle(color: Colors.red), ),
       actions: [
         submitButton("cancel", ()=>Navigator.pop(context)),
         IconButton(onPressed: (){
           deleteMessage(id);
           snackbar(context, "deleted message sucessfuly");
           Navigator.pop(context);},
          icon: Icon(Icons.delete, color: Colors.red,))
       ],

      );
    });
}

snackbar( BuildContext context, var message){
     return ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(message))
     );
}

imageBox(var name,{var height}){
  return  Container(
            height: height,
            width: double.infinity,
            child:CachedNetworkImage(
                      imageUrl: customImageUrl(name),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
          );
}
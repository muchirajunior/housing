import 'package:flutter/material.dart';
import 'package:housing/services/services.dart';

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
    default:
  }
}




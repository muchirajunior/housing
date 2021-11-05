import 'package:flutter/material.dart';

signupTabButton(var text, Function method ){
  return MaterialButton(
    onPressed:()=> method(),
    child: Text(text, style: TextStyle(fontSize: 20),),
    );
}


textInput(TextEditingController controller, var hint, bool pass){
  return Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10)),
    child: TextFormField(
      obscureText: pass,
      controller: controller,
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
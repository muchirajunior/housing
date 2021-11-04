import 'package:flutter/material.dart';
import 'package:housing/screens/components.dart';

class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  var page='login';

  tabController(){
    setState(() {
      if (page=='login') page='register';
      else page='login';
    });
  }

  TextEditingController name=TextEditingController();
  TextEditingController username=TextEditingController();
  TextEditingController pass=TextEditingController();
  TextEditingController confirmPass=TextEditingController();
  var _choosenValue;

   signUp(){
     print(_choosenValue);
   print(username.text);
   print(pass.text);

  }
  


  @override
  Widget build(BuildContext context) {
    final screen=MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  signupTabButton("LOGIN", tabController),
                  signupTabButton("REGISTER", tabController)
                ],
              ),
            
            SizedBox(height: 10,),
             AnimatedAlign(alignment: page=='login' ? Alignment.centerLeft : Alignment.centerRight,
              duration: Duration(seconds: 1),
              child: Container(
                color: Colors.grey,
                height: 5,
                width: screen.width*0.5,
              ),
              ),

              SizedBox(height: 20,),

              Container(
                width: screen.width*0.8,
                child: page=='login' ? loginContainer(username, pass) : registerContainer(name, username, pass, confirmPass),
              ),

              

              page=='register' ? Container(
                    width: screen.width*0.76,
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),

                      child:   DropdownButton<String>(
                      focusColor:Colors.white,
                      value: _choosenValue,
                      isExpanded: true,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor:Colors.black,
                      items: <String>[
                        'landlord',
                        'tenant'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style:TextStyle(color:Colors.black),),
                        );
                      }).toList(),
                      hint:Text(
                        "Please choose a cartegory",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String? value) {
                      setState(() {
                          _choosenValue = value;
                        });
                      },
                    ),
                  ) : Text(''),


              SizedBox(height: 30,),

              Container(
                width: screen.width*0.7,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10)),
                child: signupTabButton(page, signUp)
              )

            ],
          ),
        ),
      )
      
    );
  }
}
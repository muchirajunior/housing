import 'dart:io';
import 'package:flutter/material.dart';
import 'package:housing/screens/components.dart';
import 'package:housing/services/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({ Key? key }) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

   TextEditingController name=TextEditingController();
   TextEditingController description=TextEditingController();

   var image;
   bool loading=false;

   pickImage()async{
     var picker=ImagePicker();
     var img= await picker.pickImage(source: ImageSource.gallery);
     var pimg=File(img!.path);
     var newImage=await ImageCropper.cropImage(
       compressQuality: 100,
       aspectRatioPresets :[ CropAspectRatioPreset.square],
       sourcePath: pimg.path
     );
     setState(() {
       image=newImage;
     });
   }

   submitPost()async{
     print("submit");
     if (name.text.length>3 && description.text.length>4){
     setState(() { loading=true; });
     var res=await createNewPost(name.text, description.text, image);
     if (res=='success') { Navigator.pop(context);
          snackbar(context, "created post successfully");
     } else
     setState(() { loading=false; });
     }else alert(context, "warning", "please fill all the fields");
   }
  

  @override
  Widget build(BuildContext context) {
    var screen= MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[300],

      appBar: AppBar(
        title: Text("Create a new Post"),
      ),


      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30,),
            textInput(name, "house name", false),
            textInput(description, "brief description", false, maxlines: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 180,
                  height: 180,
                  margin: EdgeInsets.all(5),
                   decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    color: Colors.grey
                  ),
      
                  child: image != null ? Image.file(image, fit: BoxFit.cover,) : Icon(Icons.image, size: 40,),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey
                  ),
                  child: submitButton(image==null ? "upload":"change", pickImage),
                )
              ],
            ),
            
            SizedBox(height: 20,),
           loading ? CircularProgressIndicator() :
            Container(
              width: screen.width*0.6,
               decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    color: Colors.blue
                  ),
              child: submitButton("submit", submitPost)),
      
          
          ],
        ),
      ),



    );
  }
}
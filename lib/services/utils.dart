import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> currentUser()async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  
  var user={
    "id":preferences.get("id"),
    "name":preferences.get("name"),
    "username":preferences.get("username"),
    "type":preferences.get("type")
  };

  return user;
}

getImageUrl(var name)=>"https://firebasestorage.googleapis.com/v0/b/housing-77b63.appspot.com/o/images%2F$name?alt=media&token=29df7723-ba42-4c62-8047-970b6823d1be";
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
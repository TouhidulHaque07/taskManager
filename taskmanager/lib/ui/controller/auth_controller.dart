
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/data/model/user_model.dart';

class AuthController{

  static final String _accessToken='access-token';
  static final String _userDataKey='user-data';

  static String? accessToken;
  static UserModel? userData;

 static Future<void> saveAccessToken(String token) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_accessToken, token);
    accessToken=token;
  }

  static Future<void> saveUserData(UserModel userModel) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_userDataKey, jsonEncode(userModel.toJson()));
    userData=userModel;
  }

  static Future<String?> getAccessToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token= sharedPreferences.getString(_accessToken);
    accessToken=token;
    return token;
  }
  static Future<UserModel?> getUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEncodeData= sharedPreferences.getString(_userDataKey);
    if(userEncodeData==null){
      return null;
    }
    UserModel userModel=UserModel.fromJson(jsonDecode(userEncodeData));
    userData=userModel;
    return userModel;
  }

 static bool isLoggedIn(){
    return accessToken != null;
  }

  static Future<void> clearUserData() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    accessToken=null;
  }


}
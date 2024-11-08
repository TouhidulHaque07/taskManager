import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:taskmanager/app.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';
import 'package:taskmanager/ui/screens/sign_in_screen.dart';

class NetworkCaller{
 static Future<NetworkResponse> getRequest({required String Url}) async {

    try {
      Uri uri=Uri.parse(Url);
      Map<String, String> headers={
        'token': AuthController.accessToken.toString(),
      };
      debugPrint(Url);
      final Response response= await get(uri, headers: headers);

      printResponse(Url, response);

      if(response.statusCode==200){
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            StatusCode: response.statusCode,
            responseData: decodeData);
      }  else if(response.statusCode==401){
        _moveToLogiun();
        return NetworkResponse(
          isSuccess: false,
          StatusCode: response.statusCode,
          erroMessage: 'UnAuthenticated!',
        );


      }else{
        return NetworkResponse(
            isSuccess: false,
            StatusCode: response.statusCode);
      }
    } catch (e) {
        return NetworkResponse(
          isSuccess: false,
          StatusCode: -1,
          erroMessage: e.toString());
    }
 }
 static Future<NetworkResponse> postRequest({required String Url, Map<String,dynamic>?body}) async {

   try {
     Uri uri=Uri.parse(Url);
     Map<String, String> headers={
       'Content-Type': 'application/json',
       'token': AuthController.accessToken.toString(),
     };
     debugPrint(Url);
     printRequest(Url, body, headers);
     final Response response= await post(uri,
          headers: headers,
          body: jsonEncode(body)

     );

     printResponse(Url, response);

     if(response.statusCode==200){
       final decodeData = jsonDecode(response.body);

       if(decodeData['status']=='fail'){
         return NetworkResponse(
             isSuccess: false,
             StatusCode: response.statusCode,
             responseData: decodeData['data']);
       }

       return NetworkResponse(
           isSuccess: true,
           StatusCode: response.statusCode,
           responseData: decodeData);
     }
     else if(response.statusCode==401){
          _moveToLogiun();
          return NetworkResponse(
              isSuccess: false,
              StatusCode: response.statusCode,
              erroMessage: 'UnAuthenticated!',
          );


     } else{
       return NetworkResponse(
           isSuccess: false,
           StatusCode: response.statusCode);
     }
   } catch (e) {
     return NetworkResponse(
         isSuccess: false,
         StatusCode: -1,
         erroMessage: e.toString());
   }
 }

 static void printRequest(String Url,Map<String, dynamic>? body,Map<String, dynamic>? headers ){
   debugPrint(
       'Request \n Url:$Url\n Body: $body \n Headers:$headers');
 }


 static void printResponse(String Url, Response response ){
   debugPrint(
       'Url:$Url\n '
           'Response Code: ${response.statusCode} \n '
           'Body:${response.body}');
 }

 static Future<void> _moveToLogiun() async {
   await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(TaskManagerApp.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => SignInScreen()), (p) => false);
  }

}
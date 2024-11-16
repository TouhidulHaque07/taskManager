
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractices/hoom_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String name='/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile..'),
      ),
       body: Center(
         child: Column(
           children: [
             TextButton(
                 onPressed: (){
                //Navigator.pop(context);
                   Get.back();
             }, child: Text('Go Back...')),
             TextButton(
                 onPressed: (){
                   //Navigator.pop(context);
                  // Get.back();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HoomScreen()),
                      (predicted) => false);
                },
                child: Text('Home')),
          ],
        ),
       ),
    );
  }
}

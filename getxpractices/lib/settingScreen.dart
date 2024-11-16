
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractices/profileScreen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  static const String name='/setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
       body: Center(
         child: Column(
           children: [
            TextButton(
                onPressed: () {
                  //Navigator.pop(context);
                  Get.back();
                },
                child: Text('Go Back...')),
            ElevatedButton(
                onPressed: () {
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => ProfileScreen()));
                  Get.off(ProfileScreen());
                }, child: Text('Profile'))
           ],
         ),
       ),
    );
  }
}

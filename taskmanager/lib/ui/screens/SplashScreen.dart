import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';
import 'package:taskmanager/ui/screens/main_button_nav_bar_screen.dart';
import 'package:taskmanager/ui/screens/sign_in_screen.dart';
import 'package:taskmanager/ui/utilits/assetspath.dart';
import 'package:taskmanager/ui/widgets/Screen_background.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});
  static const String name='/';

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    await AuthController.getAccessToken();
    if(AuthController.isLoggedIn()){
      await AuthController.getUserData();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainButtonNavBarScreen()));
    }else{
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Screenbackground(child:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SvgPicture.asset(AssestsPath.logoSVG,width: 120,),
          ],
        ),
      ),)
    );
  }
}




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controller_binder.dart';
import 'package:taskmanager/ui/screens/SplashScreen.dart';

import 'ui/screens/main_button_nav_bar_screen.dart';
import 'ui/utilits/app_colors.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey=GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themColor,
          textTheme: const TextTheme(),
          inputDecorationTheme: _inputDecorationTheme(),
          elevatedButtonTheme: _elevatedButtonThemeData(),
      ),

      initialBinding: ControllerBinder(),
      initialRoute: '/',
      routes: {
        Splashscreen.name:(context)=> const Splashscreen(),
        MainButtonNavBarScreen.name: (context)=> const MainButtonNavBarScreen(),
      },

    );
  }
}

ElevatedButtonThemeData _elevatedButtonThemeData(){
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.themColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        fixedSize: const Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )
    ),
  );
}

InputDecorationTheme _inputDecorationTheme() {
  return InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    hintStyle: const TextStyle(
      fontWeight: FontWeight.w300,
    ),
    border: _inputBorder(),
    enabledBorder: _inputBorder(),
    focusedBorder: _inputBorder(),
    errorBorder: _inputBorder(),
  );
}

OutlineInputBorder _inputBorder(){
 return  OutlineInputBorder(
     borderSide: BorderSide.none,
     borderRadius: BorderRadius.circular(8));

}

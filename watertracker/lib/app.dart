import 'package:flutter/material.dart';
import 'package:watertracker/home_Screen.dart';

class waterTrackerApp extends StatelessWidget {
  const waterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

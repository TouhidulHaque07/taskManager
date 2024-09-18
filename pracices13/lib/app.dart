import 'package:flutter/material.dart';
import 'package:pracices13/screen/home_screen.dart';

class CRUDAP extends StatelessWidget {
  const CRUDAP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homeScreen(),
    );
  }
}

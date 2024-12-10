import 'package:flutter/material.dart';
import 'package:googlemap/home_screen.dart';
import 'package:googlemap/loation.dart';
import 'package:googlemap/myLocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  //runApp() => GoogleMapApp();
  runApp(GoogleMapApp());
}

class GoogleMapApp extends StatelessWidget {
  const GoogleMapApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Mylocation(),
    );
  }
}


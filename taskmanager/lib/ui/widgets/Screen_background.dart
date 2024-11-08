import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskmanager/ui/utilits/assetspath.dart';

class Screenbackground extends StatelessWidget {
  const Screenbackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    Size ScreenSize=MediaQuery.sizeOf(context);
    return  Stack(
      children: [
        SvgPicture.asset(AssestsPath.backgroundSVG,
          fit: BoxFit.cover,
          height:ScreenSize.height,
          width:ScreenSize.width ,),
        SafeArea(child: child),
      ],
    );
  }
}
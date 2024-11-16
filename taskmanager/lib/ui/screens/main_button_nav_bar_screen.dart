import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/cancel_task_screen.dart';
import 'package:taskmanager/ui/screens/complete_task_screen.dart';
import 'package:taskmanager/ui/screens/new_task_screen.dart';
import 'package:taskmanager/ui/screens/prograss_task_screen.dart';
import 'package:taskmanager/ui/utilits/app_colors.dart';
import 'package:taskmanager/ui/widgets/tm_app_bar.dart';

class MainButtonNavBarScreen extends StatefulWidget {
  const MainButtonNavBarScreen({super.key});

  static const String name='/home';

  @override
  State<MainButtonNavBarScreen> createState() => _MainButtonNavBarScreenState();
}

class _MainButtonNavBarScreenState extends State<MainButtonNavBarScreen> {
  int _selectIndex=0;
  final List<Widget> _screen=const [
    NewTaskScreen(),
    CompleteTaskScreen(),
    CancelTaskScreen(),
    ProgressTaskScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screen[_selectIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex:_selectIndex,
        onDestinationSelected: (int index){
          _selectIndex=index;
          setState(() {

          });
        } ,
          destinations: [const
            NavigationDestination(
              icon: Icon(Icons.new_label),
              label: 'New'
          ),  NavigationDestination(
              icon: Icon(Icons.check_box),
              label: 'Complete'
          ), NavigationDestination(
              icon: Icon(Icons.close),
              label: 'Cancled'
          ), NavigationDestination(
              icon: Icon(Icons.access_time_outlined),
              label: 'Progress'
          )
          ]),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpractices/counter_controller.dart';
import 'package:getxpractices/settingScreen.dart';

class HoomScreen extends StatefulWidget {
  const HoomScreen({super.key});
  static const String name='/';
  @override
  State<HoomScreen> createState() => _HoomScreenState();

}

class _HoomScreenState extends State<HoomScreen> {

// CounterController counterController = CounterController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Home', style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),),
      ),
      body:
      Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          GetBuilder<CounterController>(builder: (counterController) {
            return Text(
              '${counterController.count}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            );
          }),
          ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => SettingScreen()),
              // );
             // Get.to(()=>SettingScreen());
              //Navigator.pushNamed((context), '/setting');
              Get.toNamed(SettingScreen.name);
       },
            child: Text('Setting'),
          ),
            ElevatedButton(onPressed: (){
              Get.showSnackbar(const GetSnackBar(
                title: 'Titel',
                message: 'This is a message',
                duration: Duration(seconds: 3),
              ),);
            }, child: Text('Show Snacbar Massage'),),
        ],
      )
      ),

        floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.find<CounterController>().increment();
        },
        child: const Icon(Icons.add),
    ),

    );
  }



}



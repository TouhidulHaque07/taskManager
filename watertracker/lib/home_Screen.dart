
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassNoTEController=TextEditingController(
    text: '1' );
  List<waterTraker> WaterTrackerList=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Tracker'),
        centerTitle: true,
      ),
      body:
      _buildWaterTrackerCounter(),

    );
  }

  Widget _buildWaterTrackerCounter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          getTotalGlassCount().toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          'Glass/s',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _glassNoTEController,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
                onPressed: _onTapaddWaterTrack,
                child: Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
        const SizedBox(height: 25,),
        Expanded(
          child: _waterTrackerListView(),)
      ],
    );
  }

  Widget _waterTrackerListView() {
    return ListView.separated(
        itemCount: WaterTrackerList.length,
            itemBuilder: (context, index) {
          final waterTraker WaterTracker=WaterTrackerList[index];
              return ListTile(
                title: Text('${WaterTracker.dateTime.hour} : ${WaterTracker.dateTime.minute}'),
                subtitle: Text('${WaterTracker.dateTime.day} / ${WaterTracker.dateTime.month} /${WaterTracker.dateTime.year}'),
                leading: CircleAvatar(child: Text('${WaterTracker.noOfGlaess}')),
                trailing: IconButton(
                    onPressed: ()=>_onTapDeleteButton(index),
                    icon: Icon(Icons.delete)),
              );
            },
            separatorBuilder: (context, index){
                return Divider();
              },
             );
  }

  int getTotalGlassCount(){
    int counter=0;
    for(waterTraker t in WaterTrackerList){
      counter +=t.noOfGlaess;
    }
    return counter;
  }



  void _onTapaddWaterTrack(){

    if(_glassNoTEController.text.isEmpty){
      _glassNoTEController.text='1';
    }

    final int NoOfGlassWater=int.tryParse(_glassNoTEController.text)?? 1;
    waterTraker WaterTracker=waterTraker(noOfGlaess: NoOfGlassWater, dateTime: DateTime.now());
    WaterTrackerList.add(WaterTracker);
    setState(() { });
  }

  void _onTapDeleteButton(int index){
    WaterTrackerList.removeAt(index);

    setState(() {  });
  }

}


class waterTraker{
  final int noOfGlaess;
  final DateTime dateTime;

  waterTraker({required this.noOfGlaess, required this.dateTime});
}

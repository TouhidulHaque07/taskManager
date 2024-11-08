
import 'package:flutter/material.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_model.dart';
import '../../data/model/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snacbar_massage.dart';
import '../widgets/task_card.dart';





class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  bool _getCompleteTaskListInProgress=false;

  List<TaskModel> _completeTaskList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCompleteTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child:  Visibility(
        visible: !_getCompleteTaskListInProgress,
        replacement: Text('Wait'),
        child: RefreshIndicator(
          onRefresh: ()async {
            _getCompleteTaskList();
          },
          child: ListView.separated(
            itemCount: _completeTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                onRefreshList: _getCompleteTaskList,
                taskModel: _completeTaskList[index],
              );
            },
            separatorBuilder: (context,index){
              return const SizedBox(height: 8);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getCompleteTaskList() async {
    _getCompleteTaskListInProgress=true;
    final NetworkResponse response =
    await NetworkCaller.getRequest(Url: urls.CompleteTaskList);
    if(response.isSuccess){
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);
      _completeTaskList=taskListModel.taskList ?? [];
    }else{
      showSnacBarMassage(context, response.erroMessage,true);
    }
    _getCompleteTaskListInProgress=false;
    setState(() { });
  }


}

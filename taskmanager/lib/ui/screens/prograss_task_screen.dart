
import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/task_card.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_model.dart';
import '../../data/model/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snacbar_massage.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getPrograssTaskListInProgress=false;

  List<TaskModel> _prograsslTaskList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPrograssTaskList();
  }

  Widget build(BuildContext context) {
    return  Center(
      child:  Visibility(
        visible: !_getPrograssTaskListInProgress,
        replacement: Text('Wait'),
        child: RefreshIndicator(
          onRefresh: () async {
            _getPrograssTaskList();
          },
          child: ListView.separated(
            itemCount: _prograsslTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                onRefreshList: _getPrograssTaskList,
                taskModel: _prograsslTaskList[index],
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

  Future<void> _getPrograssTaskList() async {
    _getPrograssTaskListInProgress=true;
    final NetworkResponse response =
    await NetworkCaller.getRequest(Url: urls.prograssTaskList);
    if(response.isSuccess){
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);
      _prograsslTaskList=taskListModel.taskList ?? [];
    }else{
      showSnacBarMassage(context, response.erroMessage,true);
    }
    _getPrograssTaskListInProgress=false;
    setState(() { });
  }
}


import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/task_card.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_model.dart';
import '../../data/model/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snacbar_massage.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  bool _getCancelTaskListInProgress=false;

  List<TaskModel> _cancelTaskList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCancelTaskList();
  }

  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: !_getCancelTaskListInProgress,
        replacement: Text('Wait'),
        child: RefreshIndicator(
          onRefresh: () async {
            _getCancelTaskList();
          },
          child: ListView.separated(
            itemCount: _cancelTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                  onRefreshList: _getCancelTaskList,
                  taskModel: _cancelTaskList[index],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getCancelTaskList() async {
    _getCancelTaskListInProgress=true;
    final NetworkResponse response =
    await NetworkCaller.getRequest(Url: urls.CancelTaskList);
    if(response.isSuccess){
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);
      _cancelTaskList=taskListModel.taskList ?? [];
    }else{
      showSnacBarMassage(context, response.erroMessage,true);
    }
    _getCancelTaskListInProgress=false;
    setState(() { });
  }
}

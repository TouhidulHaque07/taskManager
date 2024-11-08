
import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/task_list_model.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/model/task_status_count_model.dart';
import 'package:taskmanager/data/model/task_status_model.dart';
import 'package:taskmanager/data/service/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/screens/add_new_task_screen.dart';
import 'package:taskmanager/ui/utilits/app_colors.dart';
import 'package:taskmanager/ui/widgets/snacbar_massage.dart';
import 'package:taskmanager/ui/widgets/task_card.dart';
import 'package:taskmanager/ui/widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();

}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskListInProgress=false;
  bool _getTaskStatusountnProgress=false;

  List<TaskModel> _newTaskList=[];
  List<TaskStatusModel> _taskStatusCountList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNewTaskList();
    _getStatusountLst();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
            _getNewTaskList();
            _getStatusountLst();
        },
        child: Column(
          children: [
            _buildSummarySection(),
             Expanded(
              child:
              Visibility(
                visible: !_getNewTaskListInProgress,
                replacement: Text('Wait'),
                child: ListView.separated(
                  itemCount: _newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(taskModel: _newTaskList[index],
                      onRefreshList: (){
                        _getNewTaskList();
                      },
                    );
                  },
                  separatorBuilder: (context,index){
                    return const SizedBox(height: 8);
                },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed:_OnTapNewFAB,
     child: Icon(Icons.add),
     ),
    );
  }

  Widget _buildSummarySection() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _getTaskSummaryList(),

          ),
        ),
      );
  }

  List<TaskSummaryCard> _getTaskSummaryList(){
    List<TaskSummaryCard> taskSummaryCardList=[];
    for(TaskStatusModel t in _taskStatusCountList){

      taskSummaryCardList.add(TaskSummaryCard(title: t.sId!, count: t.sum ?? 0));

    }
    return taskSummaryCardList;
  }

  void _OnTapNewFAB(){

    Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => AddNewTaskScreen(),
        ));


  }

  Future<void> _getNewTaskList() async {
        _getNewTaskListInProgress=true;
        final NetworkResponse response =
        await NetworkCaller.getRequest(Url: urls.newTaskList);
        if(response.isSuccess){
          final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
          _newTaskList=taskListModel.taskList ?? [];
    }else{
          showSnacBarMassage(context, response.erroMessage,true);
        }
        _getNewTaskListInProgress=false;
        setState(() { });
  }
  Future<void> _getStatusountLst() async {
    _taskStatusCountList.clear();
   _getTaskStatusountnProgress=true;
    final NetworkResponse response =
    await NetworkCaller.getRequest(Url: urls.taskStatusount);
    if(response.isSuccess){
      final TaskStatusCountModel taskStatusCountModel =
      TaskStatusCountModel.fromJson(response.responseData);
      _taskStatusCountList=taskStatusCountModel.taskStatusCountLst ?? [];
    }else{
      showSnacBarMassage(context, response.erroMessage,true);
    }
    _getTaskStatusountnProgress=false;
    setState(() { });
  }


}





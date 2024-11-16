
import 'package:get/get.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/task_list_model.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/service/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';

class NewTaskListController extends GetxController{
  bool _inProgress=false;

  String? _errorMessage;

  List<TaskModel> _taskList=[];

  bool get inprogress=> _inProgress;

  String? get errorMessage=>_errorMessage;

  List<TaskModel> get taskList=>_taskList;

  Future<bool> getNewTaskList() async {

    bool isSuccess=false;
    _inProgress=true;
    update();

    final NetworkResponse response =
    await NetworkCaller.getRequest(Url: urls.newTaskList);
    if(response.isSuccess){
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);
      _taskList=taskListModel.taskList ?? [];
      isSuccess=true;
    }else{
      _errorMessage=response.erroMessage;
    }
    _inProgress=false;
    update();

    return isSuccess;

  }

}
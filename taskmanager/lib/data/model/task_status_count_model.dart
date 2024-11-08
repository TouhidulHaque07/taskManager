import 'package:taskmanager/data/model/task_status_model.dart';

class TaskStatusCountModel {
  String? status;
  List<TaskStatusModel>? taskStatusCountLst;

  TaskStatusCountModel({this.status, this.taskStatusCountLst});

  TaskStatusCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskStatusCountLst = <TaskStatusModel>[];
      json['data'].forEach((v) {
        taskStatusCountLst!.add(TaskStatusModel.fromJson(v));
      });
    }
  }

}


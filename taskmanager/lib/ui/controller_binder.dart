
import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/new_task_list_controller.dart';
import 'package:taskmanager/ui/controller/sign_in_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(NewTaskListController());
  }



}
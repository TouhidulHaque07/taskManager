class urls {
  static const String _baseUrl='http://35.73.30.144:2005/api/v1';
  static const String registration='$_baseUrl/Registration';
  static const String login='$_baseUrl/Login';
  static const String addNewTask='$_baseUrl/createTask';
  static const String newTaskList='$_baseUrl/listTaskByStatus/New';
  static const String CompleteTaskList='$_baseUrl/listTaskByStatus/Complete';
  static const String CancelTaskList='$_baseUrl/listTaskByStatus/Cancel';
  static const String prograssTaskList='$_baseUrl/listTaskByStatus/Prograss';
  static const String taskStatusount='$_baseUrl/taskStatusCount';
  static const String updateProfile='$_baseUrl/ProfileUpdate';


  static String changeStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';
  static String deleteStatus(String taskId) =>
      '$_baseUrl/deleteTask/$taskId';
}
class Urls{
  Urls._();
  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static const String registration = "$_baseUrl/registration";
  static const String login = "$_baseUrl/login";
  static const String createTask = "$_baseUrl/createTask";
  static const String taskStatusCount = "$_baseUrl/taskStatusCount";
  static const String newTasks = "$_baseUrl/listTaskByStatus/New";
  static const String progressTasks = "$_baseUrl/listTaskByStatus/New";
  static const String completedTasks = "$_baseUrl/listTaskByStatus/Completed";
  static const String cancelTasks = "$_baseUrl/listTaskByStatus/Cancelled";
  static String deleteTask(String id) => "$_baseUrl/deleteTask/$id";
}
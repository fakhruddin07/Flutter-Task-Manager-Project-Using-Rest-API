import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class GetNewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getNewTaskInProgress => _getNewTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getNewTask() async {
    _getNewTaskInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTasks);

    _getNewTaskInProgress = false;
    update();

    if (response.statusCode == 200) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      return true;
    } else {
      return false;
    }
  }
}

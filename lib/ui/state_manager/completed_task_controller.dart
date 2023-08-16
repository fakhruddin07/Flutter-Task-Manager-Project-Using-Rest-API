import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CompletedTaskController extends GetxController {
  TaskListModel _taskListModel = TaskListModel();
  bool _getCompletedTaskInProgress = false;

  TaskListModel get taskListModel => _taskListModel;
  bool get getCompletedTaskInProgress => _getCompletedTaskInProgress;

  Future<bool> getCompletedTask() async {
    _getCompletedTaskInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.completedTasks);

    _getCompletedTaskInProgress = false;
    update();

    if (response.statusCode == 200) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      return true;
    } else {
      return false;
    }
  }
}

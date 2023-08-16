import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class ProgressTaskController extends GetxController{
  TaskListModel _taskListModel = TaskListModel();
  bool _getProgressTaskInProgress = false;

  TaskListModel get taskListModel => _taskListModel;
  bool get getProgressTaskInProgress => _getProgressTaskInProgress;

  Future<bool> getInProgressTask() async {
    _getProgressTaskInProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.progressTasks);

    _getProgressTaskInProgress = false;
    update();

    if (response.statusCode == 200) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      return true;
    } else {
      return false;
      /*if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("In Progress task list data get failed"),
          ),
        );
      }*/
    }
  }
}
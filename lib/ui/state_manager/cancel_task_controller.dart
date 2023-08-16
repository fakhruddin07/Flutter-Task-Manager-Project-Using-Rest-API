import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CancelTaskController extends GetxController {
  TaskListModel _taskListModel = TaskListModel();
  bool _getCancelTaskInProgress = false;

  TaskListModel get taskListModel => _taskListModel;
  bool get getCancelTaskInProgress => _getCancelTaskInProgress;

  void getUpdateState() {
    update();
  }

  Future<bool> getCancelledTask() async {
    _getCancelTaskInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.cancelTasks);

    _getCancelTaskInProgress = false;
    update();

    if (response.statusCode == 200) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      return true;
    } else {
      return false;
    }
  }
}

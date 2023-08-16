import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class UpdateTaskStateController extends GetxController{
  bool _updateTaskStatusInProgress = false;
  bool get updateTaskStatusInProgress => _updateTaskStatusInProgress;

  Future<bool> updateTaskStatus(String taskId, String newStatus) async {
    _updateTaskStatusInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.listTaskByStatus(taskId, newStatus));

    _updateTaskStatusInProgress = false;
    update();

    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
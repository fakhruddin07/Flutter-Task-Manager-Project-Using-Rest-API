import 'package:get/get.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/get_new_task_controller.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class DeleteTaskController extends GetxController {
  final GetNewTaskController _getNewTaskController =
      Get.find<GetNewTaskController>();

  Future<bool> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteTask(taskId));

    if (response.isSuccess) {
      _getNewTaskController.taskListModel.data!
          .removeWhere((element) => element.sId == taskId);
      update();
      return true;
    } else {
      return false;
    }
  }
}

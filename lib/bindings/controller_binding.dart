import 'package:get/get.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/add_new_task_controller.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/completed_task_controller.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/update_profile_controller.dart';
import '../ui/state_manager/cancel_task_controller.dart';
import '../ui/state_manager/get_new_task_controller.dart';
import '../ui/state_manager/delete_task_controller.dart';
import '../ui/state_manager/login_controller.dart';
import '../ui/state_manager/progress_task_controller.dart';
import '../ui/state_manager/summary_count_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
    Get.put<SummaryCountController>(SummaryCountController());
    Get.put<GetNewTaskController>(GetNewTaskController());
    Get.put<DeleteTaskController>(DeleteTaskController());
    Get.put<ProgressTaskController>(ProgressTaskController());
    Get.put<CancelTaskController>(CancelTaskController());
    Get.put<CompletedTaskController>(CompletedTaskController());
    Get.put<AddNewTaskController>(AddNewTaskController());
    Get.put<UpdateProfileController>(UpdateProfileController());
  }
}
import 'package:get/get.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/add_new_task_controller.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/completed_task_controller.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/email_verification_controller.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/otp_verification_controller.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/reset_password_controller.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/signup_controller.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/update_profile_controller.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/update_task_state_controller.dart';
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
    Get.put<UpdateTaskStateController>(UpdateTaskStateController());
    Get.put<EmailVerificationController>(EmailVerificationController());
    Get.put<OtpVerificationController>(OtpVerificationController());
    Get.put<ResetPasswordController>(ResetPasswordController());
    Get.put<SignupController>(SignupController());
  }
}
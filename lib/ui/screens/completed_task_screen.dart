import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/update_task_status_sheet.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/completed_task_controller.dart';
import '../../data/models/task_list_model.dart';
import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_app_bar.dart';
import '../state_manager/delete_task_controller.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompletedTaskController _completedTaskController =
      Get.find<CompletedTaskController>();
  final DeleteTaskController _deleteTaskController =
      Get.find<DeleteTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _completedTaskController.getCompletedTask().then((result) {
        if (result == false) {
          Get.snackbar("Failed!", "Completed task list data get failed");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileAppBar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _completedTaskController.getCompletedTask().then((result) {
                    if (result == false) {
                      Get.snackbar("Failed", "Completed Task data get failed");
                    }
                  });
                },
                child: GetBuilder<CompletedTaskController>(builder: (_) {
                  return _completedTaskController.getCompletedTaskInProgress
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(height: 4);
                          },
                          itemCount: _completedTaskController
                              .taskListModel.data!.length,
                          itemBuilder: (context, index) {
                            return TaskListTile(
                              data: _completedTaskController
                                  .taskListModel.data![index],
                              onEditTap: () {
                                showStatusUpdateSheet(_completedTaskController
                                    .taskListModel.data![index]);
                              },
                              onDeleteTap: () {
                                deleteAlert(index);
                              },
                            );
                          },
                        );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showStatusUpdateSheet(TaskData task) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(
          task: task,
          onUpdate: () {
            _completedTaskController.getCompletedTask();
          },
        );
      },
    );
  }

  void deleteAlert(int index) {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Delete Alert',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Do you want to delete this item?",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _deleteTaskController
                  .deleteTask(
                      _completedTaskController.taskListModel.data![index].sId!)
                  .then((value) {
                if (value) {
                  Get.snackbar(
                    'Success',
                    'Task deletion successful!',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    borderRadius: 10,
                  );
                } else {
                  Get.snackbar(
                    'Failed',
                    'Task deletion failed!',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    borderRadius: 10,
                  );
                }
              });
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}

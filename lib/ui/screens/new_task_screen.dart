import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_using_rest_api/data/models/task_list_model.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/update_task_status_sheet.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/delete_task_controller.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/get_new_task_controller.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/summary_count_controller.dart';
import 'package:task_manager_project_using_rest_api/widgets/screen_background.dart';

import '../../widgets/summary_card.dart';
import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_app_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final SummaryCountController _summaryCountController =
      Get.find<SummaryCountController>();
  final GetNewTaskController _getNewTaskController =
      Get.find<GetNewTaskController>();
  final DeleteTaskController _deleteTaskController =
      Get.find<DeleteTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _summaryCountController.getCountSummary().then((result) {
        if (result == false) {
          Get.snackbar("Failed", "Summary data get failed");
        }
      });
      _getNewTaskController.getNewTask().then((result) {
        if (result == false) {
          Get.snackbar("Failed", "New Task data get failed");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileAppBar(),
            GetBuilder<SummaryCountController>(builder: (_) {
              if (_summaryCountController.getCountSummaryInProgress) {
                return const Center(child: LinearProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return const Divider(height: 4);
                    },
                    itemCount:
                        _summaryCountController.summaryCountModel.data!.length,
                    itemBuilder: (context, index) {
                      return SummaryCard(
                        title: _summaryCountController
                                .summaryCountModel.data![index].sId ??
                            "New",
                        number: _summaryCountController
                                .summaryCountModel.data![index].sum ??
                            0,
                      );
                    },
                  ),
                ),
              );
            }),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _getNewTaskController.getNewTask().then((result) {
                    if (result == false) {
                      Get.snackbar("Failed", "Summary data get failed");
                    }
                  });
                  _summaryCountController.getCountSummary().then((result) {
                    if (result == false) {
                      Get.snackbar("Failed", "New Task data get failed");
                    }
                  });
                },
                child: GetBuilder<GetNewTaskController>(builder: (_) {
                  return _getNewTaskController.getNewTaskInProgress
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(height: 4);
                          },
                          itemCount:
                              _getNewTaskController.taskListModel.data!.length,
                          itemBuilder: (context, index) {
                            return TaskListTile(
                              data: _getNewTaskController
                                  .taskListModel.data![index],
                              onEditTap: () {
                                showStatusUpdateSheet(_getNewTaskController
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddNewTaskScreen());
        },
        child: const Icon(Icons.add),
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
            _getNewTaskController.getNewTask();
          },
        );
      },
    );
  }

  void deleteAlert(int index){
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
              _deleteTaskController.deleteTask(
                  _getNewTaskController
                      .taskListModel.data![index].sId!)
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

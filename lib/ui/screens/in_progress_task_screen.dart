import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/update_task_status_sheet.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/progress_task_controller.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_app_bar.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  final ProgressTaskController _progressTaskController =
      Get.find<ProgressTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _progressTaskController.getInProgressTask().then((result) {
        if (result == false) {
          Get.snackbar("Failed", "Progress Task data get failed");
        }
      });
    });
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteTask(taskId));

    if (response.isSuccess) {
      _progressTaskController.taskListModel.data!
          .removeWhere((element) => element.sId == taskId);
      if (mounted) {
        setState(() {});
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Delete task failed"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileAppBar(),
            Expanded(
              child: GetBuilder<ProgressTaskController>(builder: (_) {
                return _progressTaskController.getProgressTaskInProgress
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider(height: 4);
                        },
                        itemCount:
                            _progressTaskController.taskListModel.data!.length,
                        itemBuilder: (context, index) {
                          return TaskListTile(
                            data: _progressTaskController
                                .taskListModel.data![index],
                            onEditTap: () {
                              showStatusUpdateSheet(_progressTaskController
                                  .taskListModel.data![index]);
                            },
                            onDeleteTap: () {
                              deleteTask(_progressTaskController
                                  .taskListModel.data![index].sId!);
                            },
                          );
                        },
                      );
              }),
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
            _progressTaskController.getInProgressTask();
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/update_task_status_sheet.dart';

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
  TaskListModel _taskListModel = TaskListModel();

  bool _getProgressTaskInProgress = false;

  Future<void> getInProgressTask() async {
    _getProgressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.progressTasks);

    if (response.statusCode == 200) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("In Progress task list data get failed"),
          ),
        );
      }
    }

    _getProgressTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getInProgressTask();
    });
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTask(taskId));

    if (response.isSuccess) {
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
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
              child: _getProgressTaskInProgress
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider(height: 4);
                      },
                      itemCount: _taskListModel.data!.length,
                      itemBuilder: (context, index) {
                        return TaskListTile(
                          data: _taskListModel.data![index],
                          onEditTap: () {
                            showStatusUpdateSheet(
                                _taskListModel.data![index]);
                          },
                          onDeleteTap: () {
                            deleteTask(_taskListModel.data![index].sId!);
                          },
                        );
                      },
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
            getInProgressTask();
          },
        );
      },
    );
  }

}

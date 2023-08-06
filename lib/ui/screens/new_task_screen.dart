import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/data/models/network_response.dart';
import 'package:task_manager_project_using_rest_api/data/models/summery_count_model.dart';
import 'package:task_manager_project_using_rest_api/data/models/task_list_model.dart';
import 'package:task_manager_project_using_rest_api/data/services/network_caller.dart';
import 'package:task_manager_project_using_rest_api/data/utility/urls.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/update_task_status_sheet.dart';
import 'package:task_manager_project_using_rest_api/widgets/screen_background.dart';

import '../../widgets/summary_card.dart';
import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_banner.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  TaskListModel _taskListModel = TaskListModel();

  bool _getCountSummaryInProgress = false;
  bool _getNewTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCountSummary();
      getNewTask();
    });
  }

  Future<void> getCountSummary() async {
    _getCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.taskStatusCount);

    if (response.statusCode == 200) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Summary data get failed"),
          ),
        );
      }
    }

    _getCountSummaryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNewTask() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTasks);

    if (response.statusCode == 200) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("new task list data get failed"),
          ),
        );
      }
    }

    _getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
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
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileBanner(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _getCountSummaryInProgress
                  ? const LinearProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 80,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const Divider(height: 4);
                          },
                          itemCount: _summaryCountModel.data!.length,
                          itemBuilder: (context, index) {
                            return SummaryCard(
                              title:
                                  _summaryCountModel.data![index].sId ?? "New",
                              number: _summaryCountModel.data![index].sum ?? 0,
                            );
                          },
                        ),
                      ),
                    ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getNewTask();
                },
                child: _getNewTaskInProgress
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
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
            getNewTask();
          },
        );
      },
    );
  }
}

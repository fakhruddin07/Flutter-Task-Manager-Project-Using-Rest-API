import 'package:flutter/material.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_banner.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  TaskListModel _taskListModel = TaskListModel();

  bool _getCompletedTaskInProgress = false;

  Future<void> getCompletedTask() async {
    _getCompletedTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.completedTasks);

    if (response.statusCode == 200) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("In Progress task list data get failed"),
        ),
      );
    }

    _getCompletedTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCompletedTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileBanner(),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(height: 4);
                },
                itemCount: _taskListModel.data!.length,
                itemBuilder: (context, index) {
                  return TaskListTile(
                    data: _taskListModel.data![index],
                    onEditTap: () {},
                    onDeleteTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

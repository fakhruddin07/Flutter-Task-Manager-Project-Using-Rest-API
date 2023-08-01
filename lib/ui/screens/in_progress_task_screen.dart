import 'package:flutter/material.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_banner.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("In Progress task list data get failed"),
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileBanner(),
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

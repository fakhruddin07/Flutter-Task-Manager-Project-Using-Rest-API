import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/data/models/task_list_model.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class UpdateTaskStatusSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;
  const UpdateTaskStatusSheet(
      {super.key, required this.task, required this.onUpdate});

  @override
  State<UpdateTaskStatusSheet> createState() => _UpdateTaskStatusSheetState();
}

class _UpdateTaskStatusSheetState extends State<UpdateTaskStatusSheet> {
  List<String> taskStatusList = ["New", "Progress", "Canceled", "Completed"];
  late String _selectedStatus;
  bool updateTaskStatusInProgress = false;

  @override
  initState() {
    _selectedStatus = widget.task.status!;
    super.initState();
  }

  Future<void> updateTaskStatus(String taskId, String newStatus) async {
    updateTaskStatusInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.listTaskByStatus(taskId, newStatus));

    if (response.isSuccess) {
      widget.onUpdate();
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Update task status has been failed"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Update Status",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskStatusList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    _selectedStatus = taskStatusList[index];
                    setState(() {});
                  },
                  title: Text(taskStatusList[index].toUpperCase()),
                  trailing: _selectedStatus == taskStatusList[index]
                      ? const Icon(Icons.check)
                      : null,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: Visibility(
                visible: updateTaskStatusInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    updateTaskStatus(widget.task.sId!, _selectedStatus);
                  },
                  child: const Text("Update"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

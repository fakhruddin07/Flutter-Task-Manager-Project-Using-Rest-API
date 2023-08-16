import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_using_rest_api/data/models/task_list_model.dart';
import '../state_manager/update_task_state_controller.dart';

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

  @override
  initState() {
    _selectedStatus = widget.task.status!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GetBuilder<UpdateTaskStateController>(
          builder: (updateTaskStateController) {
        return Column(
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
                  visible:
                      updateTaskStateController.updateTaskStatusInProgress ==
                          false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      updateTaskStateController
                          .updateTaskStatus(widget.task.sId!, _selectedStatus)
                          .then((result) {
                        widget.onUpdate;
                        if (result == true) {
                          Get.snackbar(
                              "Success", "Status updated successfully");
                          Get.back();
                        } else {
                          Get.snackbar(
                              "Failed!", "Status update failed");
                          Get.back();
                        }
                      });
                    },
                    child: const Text("Update"),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

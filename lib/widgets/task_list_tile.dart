import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/data/models/task_list_model.dart';

class TaskListTile extends StatelessWidget {
  final TaskData data;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;
  const TaskListTile({
    super.key,
    required this.data,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.title ?? "Unknown"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.description ?? ""),
          Text(data.createdDate ?? "Unknown"),
          Row(
            children: [
              Chip(
                label: Text(
                  data.status ?? "New",
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blue,
              ),
              const Spacer(),
              IconButton(
                onPressed: onEditTap,
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: onDeleteTap,
                icon: Icon(
                  Icons.delete,
                  color: Colors.red.shade300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

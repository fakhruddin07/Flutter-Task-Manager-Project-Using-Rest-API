import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/data/models/task_list_model.dart';

class TaskListTile extends StatefulWidget {
  final TaskData data;
  const TaskListTile({super.key, required this.data});

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.data.title ?? "Unknown"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.data.description ?? ""),
          Text(widget.data.createdDate ?? "Unknown"),
          Row(
            children: [
              Chip(
                label: Text(
                  widget.data.status ?? "New",
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blue,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {},
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

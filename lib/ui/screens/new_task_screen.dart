import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/add_new_task_screen.dart';

import '../../widgets/summary_card.dart';
import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_banner.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileBanner(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SummaryCard(number: 123, title: "New"),
                  ),
                  Expanded(
                    child: SummaryCard(number: 123, title: "Progress"),
                  ),
                  Expanded(
                    child: SummaryCard(number: 123, title: "Cancelled"),
                  ),
                  Expanded(
                    child: SummaryCard(number: 123, title: "Completed"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(height: 4);
                },
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const TaskListTile();
                },
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
}

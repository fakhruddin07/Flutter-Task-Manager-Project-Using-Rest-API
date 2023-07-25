import 'package:flutter/material.dart';

import '../../widgets/task_list_tile.dart';
import '../../widgets/user_profile_banner.dart';

class CancelTaskScreen extends StatelessWidget {
  const CancelTaskScreen({super.key});

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
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const TaskListTile();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

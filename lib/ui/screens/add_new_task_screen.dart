import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/new_task_screen.dart';
import 'package:task_manager_project_using_rest_api/widgets/screen_background.dart';
import 'package:task_manager_project_using_rest_api/widgets/user_profile_banner.dart';

class AddNewTaskScreen extends StatelessWidget {
  const AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserProfileBanner(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Add New Task",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Title",
                      ),
                    ),const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: "Description",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NewTaskScreen(),
                              ),
                                  (route) => false);
                        },
                        child: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

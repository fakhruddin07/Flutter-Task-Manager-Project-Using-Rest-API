import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/new_task_screen.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/add_new_task_controller.dart';
import 'package:task_manager_project_using_rest_api/widgets/screen_background.dart';
import 'package:task_manager_project_using_rest_api/widgets/user_profile_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserProfileAppBar(),
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
                        controller: _titleTEController,
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This field can't be an empty";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Title",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _descriptionTEController,
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This field can't be an empty";
                          }
                          return null;
                        },
                        maxLines: 10,
                        decoration: const InputDecoration(
                          hintText: "Description",
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GetBuilder<AddNewTaskController>(
                          builder: (addNewTaskController) {
                        return SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: addNewTaskController.addNewTaskProgress ==
                                false,
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: ElevatedButton(
                              onPressed: () {
                                if(!_formKey.currentState!.validate()){
                                  log(_formKey.currentState!.validate().toString());
                                  return;
                                }
                                addNewTaskController
                                    .addNewTask(
                                  _titleTEController.text.trim(),
                                  _descriptionTEController.text.trim(),
                                )
                                    .then((result) {
                                  if (result) {
                                    _titleTEController.clear();
                                    _descriptionTEController.clear();
                                    Get.snackbar(
                                        "Success", "Task added Successfully");
                                    Get.offAll(const NewTaskScreen());
                                  }
                                });
                              },
                              child:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

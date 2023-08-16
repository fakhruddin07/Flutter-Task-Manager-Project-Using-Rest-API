import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/update_profile_controller.dart';
import 'package:task_manager_project_using_rest_api/widgets/screen_background.dart';
import 'package:task_manager_project_using_rest_api/widgets/user_profile_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final UpdateProfileController _updateProfileController =
      Get.find<UpdateProfileController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? imageFile;
  ImagePicker picker = ImagePicker();

  void selectImage() {
    picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = xFile;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _emailTEController.text = _updateProfileController.userData.email ?? "";
    _firstNameTEController.text = _updateProfileController.userData.firstName ?? "";
    _lastNameTEController.text = _updateProfileController.userData.lastName ?? "";
    _mobileTEController.text = _updateProfileController.userData.mobile ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserProfileAppBar(
                  isUpdateScreen: true,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Update Profile",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          selectImage();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade700),
                                child: const Text(
                                  "Photos",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Visibility(
                                visible: imageFile != null,
                                child: Text(imageFile?.name ?? ""),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailTEController,
                        readOnly: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter your email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _firstNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "First Name",
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true && value!.length <= 4) {
                            return "Enter your first name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _lastNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Last Name",
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true && value!.length <= 4) {
                            return "Enter your last name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _mobileTEController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: "Mobile",
                        ),
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) || value!.length < 11) {
                            return "Enter your valid mobile number";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordTEController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) || value!.length < 8) {
                            return "Enter your password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      GetBuilder<UpdateProfileController>(
                          builder: (updateProfileController) {
                        return SizedBox(
                          width: double.infinity,
                          child: updateProfileController
                                      .isUpdateProfileInProgress ==
                                  false
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Visibility(
                                  // visible: _isSignUpInProgress == false,
                                  replacement: const Center(
                                      child: CircularProgressIndicator()),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                      updateProfileController
                                          .updateProfile(
                                              _firstNameTEController.text
                                                  .trim(),
                                              _lastNameTEController.text.trim(),
                                              _mobileTEController.text.trim(),
                                              _passwordTEController.text)
                                          .then((value) {
                                        if (value == true) {
                                          _passwordTEController.clear();
                                          Get.snackbar("Success",
                                              "Profile Updated successfully");
                                          Get.back();
                                        }else{
                                          Get.snackbar("Failed!",
                                              "Profile Updated failed!");
                                        }
                                      });
                                    },
                                    child: const Text("Update"),
                                  ),
                                ),
                        );
                      }),
                      const SizedBox(height: 16),
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

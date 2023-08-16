import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/signup_controller.dart';
import '../../../widgets/screen_background.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _emailTEController = TextEditingController();

  final TextEditingController _firstNameTEController = TextEditingController();

  final TextEditingController _lastNameTEController = TextEditingController();

  final TextEditingController _mobileTEController = TextEditingController();

  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 65),
                Text(
                  "Join With Us",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailTEController,
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
                GetBuilder<SignupController>(builder: (signupController) {
                  return SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: signupController.isSignUpInProgress == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          } else {
                            signupController
                                .userSignUp(
                              _emailTEController.text.trim(),
                              _firstNameTEController.text.trim(),
                              _lastNameTEController.text.trim(),
                              _mobileTEController.text.trim(),
                              _passwordTEController.text,
                            )
                                .then((result) {
                              if (result == true) {
                                _emailTEController.clear();
                                _firstNameTEController.clear();
                                _lastNameTEController.clear();
                                _mobileTEController.clear();
                                _passwordTEController.clear();
                                Get.snackbar(
                                  'Success',
                                  'Registration success!',
                                );
                              }else{
                                Get.snackbar(
                                  'Failed',
                                  'Registration failed!',
                                );
                              }
                            });
                          }
                        },
                        child: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Sign in"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

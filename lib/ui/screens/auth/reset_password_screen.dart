import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/reset_password_controller.dart';
import '../../../widgets/screen_background.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  final String otp;
  ResetPasswordScreen({super.key, required this.email, required this.otp});

  final TextEditingController _passwordTEController = TextEditingController();

  final TextEditingController _confirmPasswordTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKeys,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 65),
                Text(
                  "Set Password",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                Text(
                  "Minimum length password 8 character with letter and number combination",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _passwordTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Confirm Password",
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your confirm password';
                    } else if (value! != _passwordTEController.text) {
                      return "Confirm password does not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                GetBuilder<ResetPasswordController>(
                    builder: (resetPasswordController) {
                  return SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: resetPasswordController.setPasswordInProgress ==
                          false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKeys.currentState!.validate()) {
                            return;
                          }
                          resetPasswordController
                              .resetPassword(
                                  email, otp, _passwordTEController.text)
                              .then((result) {
                            if (result == true) {
                              Get.snackbar(
                                'Success',
                                'Password reset successful!',
                              );
                              Get.offAll(() => const LoginScreen());
                            }else{
                              Get.snackbar(
                                'Failed!',
                                'Password reset failed',
                              );
                            }
                          });
                        },
                        child: const Text("Confirm"),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "have an account?",
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

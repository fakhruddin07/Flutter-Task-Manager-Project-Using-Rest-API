import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/auth/otp_verification_screen.dart';
import 'package:task_manager_project_using_rest_api/ui/state_manager/email_verification_controller.dart';
import '../../../widgets/screen_background.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 65),
              Text(
                "Your email address",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 5),
              Text(
                "A 6 digit verification pin will send to your email address",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                  validator: (String? value) {
                    if (value?.isNotEmpty ?? true) {
                      return 'Enter your valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              GetBuilder<EmailVerificationController>(
                  builder: (emailVerificationController) {
                return SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: emailVerificationController
                            .emailVerificationInProgress ==
                        false,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        emailVerificationController
                            .sendOtpToEmail(_emailTEController.text.trim())
                            .then((result) {
                          if (result == true) {
                            Get.snackbar(
                                'Success', 'Email verification successful!');
                            Get.to(
                              OtpVerificationScreen(
                                email: _emailTEController.text.trim(),
                              ),
                            );
                          } else {
                            Get.snackbar(
                                'Failed!', 'Email verification failed!');
                          }
                        });
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
                    "have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Sign in"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

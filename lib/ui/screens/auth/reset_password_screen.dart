import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/data/models/network_response.dart';
import 'package:task_manager_project_using_rest_api/data/services/network_caller.dart';
import 'package:task_manager_project_using_rest_api/data/utility/urls.dart';

import 'login_screen.dart';
import '../../../widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;
  const ResetPasswordScreen(
      {super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  bool _setPasswordInProgress = false;

  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();

  Future<void> resetPassword() async {
    _setPasswordInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestBody = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _passwordTEController.text
    };

    NetworkResponse response =
        await NetworkCaller().postRequest(Urls.resetPassword, requestBody);

    _setPasswordInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reset password has been failed!'),
          ),
        );
      }
    }
  }

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
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _setPasswordInProgress == false,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {
                        if(!_formKeys.currentState!.validate()){
                          return;
                        }
                        resetPassword();
                      },
                      child: const Text("Confirm"),
                    ),
                  ),
                ),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/data/models/network_response.dart';
import 'package:task_manager_project_using_rest_api/data/services/network_caller.dart';
import 'package:task_manager_project_using_rest_api/data/utility/urls.dart';
import '../../../widgets/screen_background.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSignUpInProgress = false;

  Future<void> userSignUp() async {
    _isSignUpInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
      "photo": "",
    };

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.registration,
      requestBody,
    );

    if (response.isSuccess) {
      _emailTEController.clear();
      _firstNameTEController.clear();
      _lastNameTEController.clear();
      _mobileTEController.clear();
      _passwordTEController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration Success"),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration fail!"),
          ),
        );
      }
    }
    _isSignUpInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

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
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _isSignUpInProgress == false,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        } else {
                          userSignUp();
                        }
                      },
                      child: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                ),
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

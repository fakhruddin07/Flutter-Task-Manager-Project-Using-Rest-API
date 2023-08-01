import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/data/models/auth_utility.dart';
import 'package:task_manager_project_using_rest_api/data/models/login_model.dart';
import 'package:task_manager_project_using_rest_api/data/models/network_response.dart';
import 'package:task_manager_project_using_rest_api/data/services/network_caller.dart';
import 'package:task_manager_project_using_rest_api/data/utility/urls.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/auth/email_verification_screen.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/auth/signup_screen.dart';
import '../../../widgets/screen_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTKController = TextEditingController();
  final TextEditingController _passwordTKController = TextEditingController();
  bool _isLoginProgress = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> userLogin() async {
    _isLoginProgress = true;
    if(mounted){
      setState(() {});
    }

    Map<String, dynamic> requestBody = {
      "email": _emailTKController.text.trim(),
      "password": _passwordTKController.text,
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.login, requestBody);

    _isLoginProgress = false;
    if(mounted){
      setState(() {});
    }

    if (response.isSuccess) {
      LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtility.saveUserInfo(model);

      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavBaseScreen(),
            ),
            (route) => false);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Incorrect email or password"),
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
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 65),
                Text(
                  "Get Started With",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailTKController,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter your valid email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordTKController,
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) || value!.length < 8) {
                      return "Enter your valid email";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _isLoginProgress == false,
                    replacement:
                    const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {
                        userLogin();
                      },
                      child: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailVerificationScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forget Password?",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text("Sign up"),
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

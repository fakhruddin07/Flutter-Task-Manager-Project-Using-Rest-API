import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/email_verification_screen.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/signup_screen.dart';
import '../../widgets/screen_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 65),
              Text(
                "Get Started With",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              const SizedBox(height: 12),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.arrow_forward_ios_rounded),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/email_verification_screen.dart';
import '../../widgets/screen_background.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                "Join With Us",
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
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "First Name",
                ),
              ),
              const SizedBox(height: 12),
              const TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Last Name",
                ),
              ),
              const SizedBox(height: 12),
              const TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Mobile",
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
    );
  }
}

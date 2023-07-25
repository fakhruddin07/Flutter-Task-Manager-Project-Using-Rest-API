import 'package:flutter/material.dart';

import 'login_screen.dart';
import '../../widgets/screen_background.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

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
              const TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text("Confirm"),
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
    );
  }
}

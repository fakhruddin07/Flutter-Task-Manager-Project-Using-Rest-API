import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/auth/login_screen.dart';
import 'package:task_manager_project_using_rest_api/ui/utility/assets_utility.dart';
import 'package:task_manager_project_using_rest_api/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState(){
    super.initState();
    navigateToLogin();
  }

  void navigateToLogin() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Center(
            child: SvgPicture.asset(
              AssetsUtility.logoSVG,
              width: 90,
              fit: BoxFit.scaleDown,
            ),
          ),
      )
    );
  }
}

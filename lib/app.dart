import 'package:flutter/material.dart';

import 'ui/screens/splash_screen.dart';

class TasManagerApp extends StatelessWidget {
  const TasManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task Manager Project Using Rest API',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
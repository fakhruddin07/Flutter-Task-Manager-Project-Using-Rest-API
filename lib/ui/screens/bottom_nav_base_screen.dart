import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/cancel_task_screen.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/completed_task_screen.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/in_progress_task_screen.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/new_task_screen.dart';

class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({super.key});

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  int _selectedScreenIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    InProgressTaskScreen(),
    CancelTaskScreen(),
    CompletedTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        selectedItemColor: Colors.green,
        showUnselectedLabels: true,
        onTap: (int index) {
          _selectedScreenIndex = index;
          if (mounted) {
            setState(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_business), label: "New"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_tree), label: "In Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.cancel), label: "Cancel"),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: "Done"),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/data/models/auth_utility.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/auth/login_screen.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/update_profile_screen.dart';

class UserProfileBanner extends StatefulWidget {
  final bool? isUpdateScreen;
  const UserProfileBanner({super.key, this.isUpdateScreen});

  @override
  State<UserProfileBanner> createState() => _UserProfileBannerState();
}

class _UserProfileBannerState extends State<UserProfileBanner> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if ((widget.isUpdateScreen ?? false) == false) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateProfileScreen(),
              ),
            );
          }
        },
        child: Row(
          children: [
            Visibility(
              visible: (widget.isUpdateScreen ?? false) == false,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(AuthUtility.userInfo.data?.photo ?? ""),
                    radius: 15,
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AuthUtility.userInfo.data?.firstName ?? ""} ${AuthUtility.userInfo.data?.lastName ?? ""}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  AuthUtility.userInfo.data?.email ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await AuthUtility.clearUserInfo();
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false);
            }
          },
          icon: const Icon(Icons.logout_rounded),
        ),
      ],
    );
  }
}

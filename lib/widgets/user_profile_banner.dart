import 'package:flutter/material.dart';
import 'package:task_manager_project_using_rest_api/data/models/auth_utility.dart';
import 'package:task_manager_project_using_rest_api/ui/screens/auth/login_screen.dart';

class UserProfileBanner extends StatefulWidget {
  const UserProfileBanner({
    super.key,
  });

  @override
  State<UserProfileBanner> createState() => _UserProfileBannerState();
}

class _UserProfileBannerState extends State<UserProfileBanner> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.green,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(AuthUtility.userInfo.data?.photo ?? ""),
        radius: 15,
      ),
      title: Text(
        "${AuthUtility.userInfo.data?.firstName ?? ""} ${AuthUtility.userInfo.data?.lastName ?? ""}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        AuthUtility.userInfo.data?.email ?? "",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      trailing: IconButton(
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
          icon: const Icon(Icons.logout_rounded)),
    );
  }
}

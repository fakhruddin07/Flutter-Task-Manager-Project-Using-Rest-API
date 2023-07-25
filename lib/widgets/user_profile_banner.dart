import 'package:flutter/material.dart';

class UserProfileBanner extends StatelessWidget {
  const UserProfileBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      tileColor: Colors.green,
      leading: CircleAvatar(
        backgroundImage: NetworkImage("https://th.bing.com/th/id/OIP.dPNA-9RtLoDJ8eMj_7ozswHaFw?pid=ImgDet&rs=1"),
        radius: 15,
      ),
      title: Text("User name", style: TextStyle(color: Colors.white, fontSize: 14,),),
      subtitle: Text("User email", style: TextStyle(color: Colors.white, fontSize: 12,),),
    );
  }
}
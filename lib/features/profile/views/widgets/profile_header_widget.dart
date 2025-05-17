import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key, required this.username, required this.userNik});
  final String username;
  final String userNik;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 45,
          backgroundImage: AssetImage('assets/icons/ic_avatar.png'),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            const SizedBox(height: 10),
            Text(username, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            userNik != "" ? Text('NIK: $userNik', style: TextStyle(fontSize: 13, color: AppColor.descText),) : Container(),
          ],
        ),
      ],
    );
  }
}

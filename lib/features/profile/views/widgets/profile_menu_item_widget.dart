import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const ProfileMenuItemWidget({required this.title, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: AppColor.primary,),
          ],
        ),
      ),
    );
  }
}

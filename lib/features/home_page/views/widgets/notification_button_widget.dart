import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class NotificationButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  
  const NotificationButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Ink(
          width: 61,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/ic_notification.svg', // Ganti path sesuai lokasi SVG kamu
              width: 24,
              height: 24,
              color: AppColor.primary,
            ),
          ),
        ),
      ),
    );
  }
}
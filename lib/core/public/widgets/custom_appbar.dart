import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class PublicWidget {
  customAppBar({required String title, required BuildContext context}) {
    return AppBar(
        title: Text(title),
        backgroundColor: AppColor.primary,
        toolbarHeight: 100,
        titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      );
  }
}
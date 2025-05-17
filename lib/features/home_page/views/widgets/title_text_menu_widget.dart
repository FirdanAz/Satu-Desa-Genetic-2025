import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';

Text textMenuTitle(String title) {
  return Text(
    title,
    style: TextStyle(
      color: AppColor.titleText,
      fontSize: 15,
      fontWeight: FontWeight.w500
    ),
  );
}
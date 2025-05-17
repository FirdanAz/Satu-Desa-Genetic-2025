import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';


SnackBar _getSnackBar({required Widget content, Color? color, Duration? duration}) {
  return SnackBar(
    content: content,
    duration: duration ?? const Duration(seconds: 2),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    backgroundColor: color ?? AppColor.primary,
  );
}

void showSnackBar(
  BuildContext context, {
  required Widget content,
  Color? color,
  Duration? duration,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      _getSnackBar(
        duration: duration,
        color: color,
        content: content,
      ),
    );

void showErrorSnackBar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    _getSnackBar(
      duration: const Duration(seconds: 2),
      color: Colors.red,
      content: Row(
        children: [
          const Icon(Icons.close, color: Colors.white, size: 18),
          const SizedBox(width: 15),
          Text(errorMessage),
        ],
      ),
    ),
  );
}

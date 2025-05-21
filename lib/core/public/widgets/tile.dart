import 'package:flutter/material.dart';
import 'package:satu_desa/core/constant/constant.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class Tile extends StatelessWidget {
  const Tile({super.key, required this.imageUrl, this.height, this.width});

  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
            height: height ?? 50,
            width: width ?? 50,
            decoration: BoxDecoration(color: AppColor.primary),
            child: Image.network(
              Constant.baseUrlImage + imageUrl,
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : const ColoredBox(color: AppColor.primary);
              },
              errorBuilder: (context, error, stackTrace) {
                return const ColoredBox(
                  color: Colors.red,
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                  ),
                );
              },
              fit: BoxFit.cover,
            )));
  }
}

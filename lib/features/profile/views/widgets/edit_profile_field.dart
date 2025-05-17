import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class EditProfileField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const EditProfileField({
    required this.label,
    required this.controller,
    this.keyboardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColor.descText)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: AppColor.descText, fontSize: 12),
          decoration: InputDecoration(
            suffixStyle: TextStyle(color: AppColor.descText),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            suffixIcon: const Icon(Icons.edit_outlined, size: 18, color: AppColor.descText,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColor.bgButtonBorder),
            ),
          ),
        ),
      ],
    );
  }
}

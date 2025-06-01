import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final TextInputType? type;
  final String? hint;
  final String? iconEnabled;
  final String? Function(String?)? validator;
  final int maxLines;

  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    required this.title,
    this.hint,
    this.type,
    this.iconEnabled,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final isMultiline = maxLines > 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColor.descText,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          constraints: BoxConstraints(minHeight: isMultiline ? 80 : 35),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: type ?? TextInputType.text,
                  style: TextStyle(color: AppColor.descText, fontSize: 12),
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    hintText: hint ?? "",
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  validator: validator,
                ),
              ),
              if (iconEnabled == null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.edit, size: 18, color: Colors.grey),
                )
            ],
          ),
        )
      ],
    );
  }
}

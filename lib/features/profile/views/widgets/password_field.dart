import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String title;

  const PasswordField(
      {required this.controller, super.key, required this.title});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, 
        style: TextStyle(
          color: AppColor.descText,
          fontSize: 14,
          fontWeight: FontWeight.w500
        ),),
        SizedBox(height: 6,),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  obscureText: _obscureText,
                  style: TextStyle(color: AppColor.descText, fontSize: 12),
                  decoration: InputDecoration(
                    suffixStyle: TextStyle(color: AppColor.descText),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: InputBorder.none
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 24,
                color: Colors.grey.shade300,
              ),
              IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: _toggleVisibility,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class InputFieldWidget extends StatefulWidget {
  final String hintText;
  final String iconPath;
  final bool isPassword;
  final TextEditingController textEditingController;

  const InputFieldWidget({
    Key? key,
    required this.hintText,
    required this.iconPath,
    required this.isPassword,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocus = false;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocus = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            widget.iconPath,
            height: 24,
            width: 24,
            color: Colors.black54,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: widget.textEditingController,
              obscureText: (widget.isPassword && !_isVisible),
              focusNode: _focusNode,
              validator: (value) {
                if (widget.isPassword) {
                  return value.toString().length < 6
                      ? 'Kata sandi tidak boleh kurang dari 6 karakter'
                      : null;
                } else {
                  return value!.isEmpty ? 'email tidak boleh kosong' : null;
                }
              },
              decoration: InputDecoration(
                hintText: widget.isPassword ? "Password" : widget.hintText,
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 14,
                    height: 0.7,
                    color:
                        _isFocus ? AppColor.primary : const Color(0xffA8A8A8)),
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        onTap: () {
                          setState(() => _isVisible = !_isVisible);
                        },
                        child: Icon(
                          _isVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xffA8A8A8),
                        ),
                      )
                    : null,
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

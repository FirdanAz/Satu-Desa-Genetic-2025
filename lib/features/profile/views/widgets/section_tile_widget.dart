import 'package:flutter/material.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;
  const SectionTitleWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 16),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}

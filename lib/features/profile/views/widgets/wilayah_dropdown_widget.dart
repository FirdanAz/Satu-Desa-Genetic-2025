import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class WilayahDropdownWidget<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final bool isEnabled;
  final String Function(T) getLabel;
  final void Function(T?) onChanged;

  const WilayahDropdownWidget({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.getLabel,
    required this.onChanged,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        DropdownButtonFormField<T>(
          value: value,
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          style: TextStyle(
            fontSize: 14
          ),
          isExpanded: true,
          items: isEnabled
              ? items
                  .map((item) => DropdownMenuItem<T>(
                        value: item,
                        child: Text(getLabel(item), style: TextStyle(color: AppColor.descText),),
                      ))
                  .toList()
              : [],
          onChanged: isEnabled ? onChanged : null,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

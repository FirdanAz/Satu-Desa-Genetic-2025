import 'package:flutter/material.dart';
import 'package:satu_desa/core/constant/constant.dart';

class KabarDesaListCardWidget extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String date;

  const KabarDesaListCardWidget({
    super.key,
    this.imageUrl,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          imageUrl != null ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              Constant.baseUrlImage + imageUrl!,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ) : Container(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

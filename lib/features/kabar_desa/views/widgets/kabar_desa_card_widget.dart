import 'package:flutter/material.dart';
import 'package:satu_desa/core/constant/constant.dart';

class KabarDesaUtamaCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String date;

  const KabarDesaUtamaCard({
    super.key,
    this.imageUrl,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          imageUrl != null
              ? Image.network(
                  Constant.baseUrlImage + imageUrl!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : Container(),
          Container(
            width: double.maxFinite,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color.fromARGB(64, 0, 0, 0), Color.fromARGB(193, 0, 0, 0)],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 4,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        blurRadius: 4,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

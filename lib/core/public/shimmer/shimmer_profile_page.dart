import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProfilePage extends StatelessWidget {
  const ShimmerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Avatar
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 12),
            // Nama
            Container(height: 16, width: 100, color: Colors.white),
            const SizedBox(height: 8),
            // NIK
            Container(height: 12, width: 140, color: Colors.white),
            const SizedBox(height: 20),

            // Tombol Domicile & Posisi
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 32, width: 120, color: Colors.white),
                const SizedBox(width: 12),
                Container(height: 32, width: 120, color: Colors.white),
              ],
            ),
            const SizedBox(height: 24),

            // Info Desa
            Container(height: 16, width: double.infinity, color: Colors.white),
            const SizedBox(height: 8),
            Container(height: 16, width: 200, color: Colors.white),
            const SizedBox(height: 8),
            Container(height: 16, width: 140, color: Colors.white),

            const SizedBox(height: 24),

            // Pengaturan Akun
            for (int i = 0; i < 2; i++) ...[
              const SizedBox(height: 12),
              Container(height: 20, width: double.infinity, color: Colors.white),
            ],

            const SizedBox(height: 24),

            // Pusat Bantuan
            for (int i = 0; i < 2; i++) ...[
              const SizedBox(height: 12),
              Container(height: 20, width: double.infinity, color: Colors.white),
            ],
          ],
        ),
      ),
    );
  }
}

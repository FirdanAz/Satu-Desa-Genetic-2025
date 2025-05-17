import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBayarSampahPage extends StatelessWidget {
  const ShimmerBayarSampahPage({super.key});

  Widget shimmerBox({double width = double.infinity, double height = 20.0, BorderRadius? borderRadius}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        children: [
          // === CARD IURAN ===
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerBox(width: 200, height: 20), // Title
                const SizedBox(height: 10),
                shimmerBox(width: 120, height: 20), // Rp15.000/bulan
                const SizedBox(height: 20),
                shimmerBox(width: 80, height: 20), // Thn 2025
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (_) => shimmerBox(width: 40, height: 40, borderRadius: BorderRadius.circular(50))),
                ),
                const SizedBox(height: 10),
                shimmerBox(width: 200, height: 20),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: shimmerBox(width: 100, height: 36, borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // === RIWAYAT TRANSAKSI ===
          shimmerBox(width: 150, height: 20), // Title "Riwayat Transaksi"
          const SizedBox(height: 20),

          // List dummy shimmer riwayat
          Column(
            children: List.generate(4, (_) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      shimmerBox(width: 40, height: 40, borderRadius: BorderRadius.circular(12)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            shimmerBox(width: 120, height: 16),
                            const SizedBox(height: 8),
                            shimmerBox(width: 80, height: 14),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      shimmerBox(width: 60, height: 14),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

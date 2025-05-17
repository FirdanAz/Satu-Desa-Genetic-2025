import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHomePage extends StatelessWidget {
  const ShimmerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerContainer(width * 0.5, 20), // "Selamat Pagi"
                const SizedBox(height: 16),
                _shimmerRoundedBox(width, 150), // Banner desa
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (_) => _shimmerIconMenu(width)),
                ),
                const SizedBox(height: 24),
                _shimmerContainer(width * 0.3, 16), // "Dana Desa"
                const SizedBox(height: 12),
                _shimmerRoundedBox(width, 90), // Anggaran card
                const SizedBox(height: 24),
                _shimmerContainer(width * 0.4, 16), // "Agenda Desa"
                const SizedBox(height: 12),
                _shimmerRoundedBox(width, 120), // Agenda card
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _shimmerContainer(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _shimmerRoundedBox(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _shimmerIconMenu(double screenWidth) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.15,
            height: screenWidth * 0.15,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: screenWidth * 0.18,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDashboardCard extends StatelessWidget {
  const ShimmerDashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(7, (_) => _buildShimmerCard(context)),
    );
  }

  Widget _buildShimmerCard(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 24,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 12,
              width: 50,
              color: Colors.white,
            ),
            const SizedBox(height: 4),
            Container(
              height: 10,
              width: 80,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFillData extends StatelessWidget {
  const ShimmerFillData({super.key});

  Widget buildShimmerItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title "Alamat Lengkap"
          Container(
            height: 20,
            width: 150,
            margin: const EdgeInsets.only(bottom: 20),
            color: Colors.grey[300],
          ),
          buildShimmerItem(), // Provinsi
          buildShimmerItem(), // Kabupaten
          buildShimmerItem(), // Kecamatan
          buildShimmerItem(), // Desa
          buildShimmerItem(), // Kode Pos
          buildShimmerItem(), // Alamat Lengkap Kantor Desa
        ],
      ),
    );
  }
}

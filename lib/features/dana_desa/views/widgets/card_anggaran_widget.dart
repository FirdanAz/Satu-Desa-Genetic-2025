import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class CardAnggaranWidget extends StatelessWidget {
  final int totalAnggaran;
  final int anggaranTerpakai;
  final String tahunAnggaran;

  const CardAnggaranWidget({
    Key? key,
    required this.totalAnggaran,
    required this.anggaranTerpakai,
    required this.tahunAnggaran,
  }) : super(key: key);

  String formatRupiah(int amount) {
    return 'Rp${amount.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}';
  }

  @override
  Widget build(BuildContext context) {
    double persen = anggaranTerpakai / totalAnggaran;
    int sisaAnggaran = totalAnggaran - anggaranTerpakai;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColor.primary, Color(0xFF6DB389)],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tahun dan Anggaran
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tahun Anggaran',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const Text(
                'Anggaran',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    tahunAnggaran,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down_rounded,
                      color: Colors.white),
                ],
              ),
              Text(
                formatRupiah(totalAnggaran),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Jumlah terpakai dan total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatRupiah(anggaranTerpakai),
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                formatRupiah(totalAnggaran),
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Progress Bar
          Stack(
            children: [
              Container(
                height: 26,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                widthFactor: persen,
                child: Container(
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Colors.white, Color(0xFFB5E2CA)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${(persen * 100).toStringAsFixed(0)}%",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F7D58),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Sisa Anggaran
          const Text(
            'Sisa Anggaran',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            formatRupiah(sisaAnggaran),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

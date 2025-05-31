import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/kabar_desa/cubit/kabar_desa_cubit.dart';

class KabarDesaAppBarWidget extends StatelessWidget {
  const KabarDesaAppBarWidget({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tombol kembali dan judul
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            const SizedBox(width: 10),
            const Text(
              'Kabar Desa',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        // Judul besar
        const Text(
          'Kabar Terbaru dari Desa',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        // Deskripsi
        const Text(
          'Dapatkan informasi terkini seputar kegiatan, pengumuman, dan perkembangan desa langsung di genggamanmu.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 20),
        // Kolom pencarian
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: AppColor.primary),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    context.read<KabarDesaCubit>().searchKabarDesa(value);
                  },
                  style: TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Cari',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

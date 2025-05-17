import 'package:flutter/material.dart';
import 'package:satu_desa/features/aspiration/models/aspirasi_model.dart';
import 'package:satu_desa/features/aspiration/views/widgets/foto_grid_widget.dart';

class AspirasiCard extends StatelessWidget {
  final AspirasiModel data;

  const AspirasiCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = data.images.map((img) => img.path).toList();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  child: Icon(Icons.person, size: 18),
                ),
                const SizedBox(width: 8),
                Text(
                  data.judul,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 12),
            FotoGrid(fotoUrls: imageUrls),
            const SizedBox(height: 12),
            Text(
              data.judul,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(data.deskripsi),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.place, color: Colors.red, size: 16),
                const SizedBox(width: 4),
                Text(data.lokasi),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14),
                const SizedBox(width: 4),
                Text("data.tanggal"),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade600,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(data.status),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:satu_desa/core/public/function.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class PaymentReceiptCard extends StatelessWidget {
  final String nama;
  final String bulan;
  final String metodePembayaran;
  final String jumlah; 

  const PaymentReceiptCard({
    super.key,
    required this.nama,
    required this.bulan,
    required this.metodePembayaran,
    required this.jumlah,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/img_pay.png', // Ganti sesuai file kamu
              height: 120,
            ),
            const SizedBox(height: 20),
            const Text(
              'Pembayaran Diterima',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Iuran Retribusi Sampah $bulan',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.titleText,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              jumlah,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.primary,
              ),
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Nama', style: TextStyle(color: Colors.black54)),
                Text(nama, style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tanggal', style: TextStyle(color: Colors.black54)),
                Text(bulan, style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Metode Pembayaran', style: TextStyle(color: Colors.black54)),
                Text(metodePembayaran, style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.download, color: Colors.white),
                onPressed: () {
                  PublicFunction().generateStrukPembayaran(nama: nama, tanggal: bulan, metode: metodePembayaran, jumlah: jumlah);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

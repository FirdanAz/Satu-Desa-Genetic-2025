import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/bayar_sampah/views/widgets/payement_receipt_card.dart';

class PaymentDetailPage extends StatelessWidget {
  const PaymentDetailPage({super.key, required this.nama, required this.bulan, required this.metodePembayaran, required this.jumlah});
  final String nama;
  final String bulan;
  final String metodePembayaran;
  final String jumlah;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bayar Sampah'),
        backgroundColor: AppColor.primary,
        toolbarHeight: 100,
        titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColor.bgButton,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              PaymentReceiptCard(nama: nama, bulan: bulan, metodePembayaran: metodePembayaran, jumlah: jumlah)
            ],
          ),
        ),
      ),
    );
  }
}

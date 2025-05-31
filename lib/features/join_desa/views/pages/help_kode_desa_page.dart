import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class HelpKodeDesaPage extends StatelessWidget {
  const HelpKodeDesaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Cara Mendapatkan Kode Desa',
              style: TextStyle(
                color: AppColor.titleText,
                fontWeight: FontWeight.w600,
                fontSize: 16
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Ikuti langkah berikut untuk terhubung ke desa kamu di aplikasi SATU DESA.',
              style: TextStyle(fontSize: 14, color: AppColor.descText),
            ),
            SizedBox(height: 24),
            LangkahItem(
              nomor: '1.',
              judul: 'Hubungi Perangkat Desa',
              isi:
                  'Minta Kode Desa dari admin desa, sekretaris desa, atau melalui grup resmi desa Whatsapp.',
            ),
            SizedBox(height: 16),
            LangkahItem(
              nomor: '2.',
              judul: 'Dapatkan Kode 12 Digit',
              isi:
                  'Kode Desa berupa ID unik 12 digit (contoh: 372HK 82J8 182K) yang menghubungkanmu dengan data desa di aplikasi.',
            ),
            SizedBox(height: 16),
            LangkahItem(
              nomor: '3.',
              judul: 'Masukkan Kode di Aplikasi',
              isi:
                  'Buka aplikasi SATU DESA, lalu masukkan kode tersebut di halaman "Masukkan Kode Desa Anda".',
            ),
            SizedBox(height: 16),
            LangkahItem(
              nomor: '4.',
              judul: 'Verifikasi dan Gabung',
              isi:
                  'Setelah kode valid, Pengelola desa akan mengecek permintaan gabung anda',
            ),
            SizedBox(height: 16),
            LangkahItem(
              nomor: '5.',
              judul: 'Permintaan Disetujui Admin',
              isi:
                  'Setelah permintaan disetujui oleh admin anda akan otomatis bergabung ke desa tersebut',
            ),
          ],
        ),
      ),
    );
  }
}

class LangkahItem extends StatelessWidget {
  final String nomor;
  final String judul;
  final String isi;

  const LangkahItem({
    super.key,
    required this.nomor,
    required this.judul,
    required this.isi,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nomor,
          style: const TextStyle(
            fontSize: 14,
            color: AppColor.descText
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColor.descText
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isi,
                style: const TextStyle(fontSize: 14, color: AppColor.descText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

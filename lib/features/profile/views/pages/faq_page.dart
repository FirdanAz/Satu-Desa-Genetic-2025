import 'package:flutter/material.dart';
import 'package:satu_desa/core/public/widgets/custom_appbar.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FaqItem> faqs = [
      FaqItem(
        question: "Apa itu aplikasi SATU DESA?",
        answer:
            "SATU DESA adalah aplikasi untuk mendukung digitalisasi layanan desa dan keterlibatan warga.",
      ),
      FaqItem(
        question: "Siapa saja yang bisa menggunakan aplikasi ini?",
        answer:
            "Seluruh warga desa, perangkat desa, dan pihak terkait dapat menggunakan aplikasi ini.",
      ),
      FaqItem(
        question: "Bagaimana cara saya masuk ke dalam desa saya di aplikasi?",
        answer:
            "Anda dapat masuk menggunakan Kode Desa yang diberikan oleh perangkat desa Anda.",
      ),
      FaqItem(
        question:
            "Saya belum mendapatkan Kode Desa. Apa yang harus saya lakukan?",
        answer:
            "Silakan hubungi perangkat desa untuk mendapatkan Kode Desa agar dapat bergabung.",
      ),
      FaqItem(
        question: "Apakah ada biaya dalam penggunaan aplikasi ini?",
        answer:
            "Tidak. Aplikasi ini dapat digunakan secara gratis oleh warga desa.",
      ),
      FaqItem(
        question: "Apakah data saya aman?",
        answer:
            "Ya, data Anda disimpan dengan aman dan dilindungi oleh sistem keamanan aplikasi.",
      ),
    ];

    return Scaffold(
      appBar: PublicWidget()
          .customAppBar(title: "FAQ/Tanya Jawab", context: context),
      backgroundColor: Colors.white,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColor.descText, width: 1)),
            child: ExpansionTile(
              backgroundColor: Colors.white,
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              childrenPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(
                faq.question,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColor.descText),
              ),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    faq.answer,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColor.primary),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}

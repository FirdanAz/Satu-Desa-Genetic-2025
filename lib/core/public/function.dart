import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PublicFunction {
  setSystemUiOverlay(
    Color statusBarColor,
    Color systemNavigatonColor,
    Brightness brightness,
  ) async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: systemNavigatonColor,
        statusBarColor: statusBarColor,
        statusBarIconBrightness: brightness,
        statusBarBrightness: Brightness.light));
  }

  generateStrukPembayaran({
    required String nama,
    required String tanggal,
    required String metode,
    required String jumlah,
  }) async {
    final pdf = pw.Document();

    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    final tanggalStr = tanggal;
    final bulan = tanggal;

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
            child: pw.Container(
              width: 400,
              padding: const pw.EdgeInsets.all(24),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey400),
                borderRadius: pw.BorderRadius.circular(12),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Center(
                    child: pw.Icon(pw.IconData(0xe145),
                        size: 60, color: PdfColors.green),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Center(
                    child: pw.Text('Pembayaran Diterima',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Center(
                    child: pw.Text('Iuran Retribusi Sampah $bulan',
                        style: pw.TextStyle(
                            fontSize: 12, color: PdfColors.grey700)),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Center(
                    child: pw.Text(jumlah,
                        style: pw.TextStyle(
                            fontSize: 24,
                            color: PdfColors.green,
                            fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Divider(),
                  pw.SizedBox(height: 8),
                  _infoRow('Nama', nama),
                  pw.SizedBox(height: 8),
                  _infoRow('Tanggal', tanggalStr),
                  pw.SizedBox(height: 8),
                  _infoRow('Metode Pembayaran', metode),
                ],
              ),
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  pw.Widget _infoRow(String label, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label, style: const pw.TextStyle(color: PdfColors.grey700)),
        pw.Text(value, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    );
  }

  String formatTanggal(DateTime date) {
    final formatter = DateFormat('d MMM yyyy', 'id_ID');
    return formatter.format(date);
  }

  String formatRupiah(String raw) {
    final double number = double.tryParse(raw) ?? 0.0;

    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0, // hilangkan angka di belakang koma
    );

    return formatter.format(number);
  }
}

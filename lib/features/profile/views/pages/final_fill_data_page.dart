import 'package:flutter/material.dart';
import 'package:satu_desa/core/public/widgets/custom_appbar.dart';

class FinalFillDataPage extends StatefulWidget {
  const FinalFillDataPage(
      {super.key,
      required this.kartuKeluarga,
      required this.nomorInduk,
      required this.nomorTelp});
  final String kartuKeluarga;
  final String nomorInduk;
  final String nomorTelp;

  @override
  State<FinalFillDataPage> createState() => _FinalFillDataPageState();
}

class _FinalFillDataPageState extends State<FinalFillDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PublicWidget()
          .customAppBar(title: "Lengkapi Profil - Foto", context: context),
      backgroundColor: Colors.white,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class CreateAspirationPage extends StatelessWidget {
  const CreateAspirationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: AppColor.primary,
        surfaceTintColor: Colors.white,
        toolbarHeight: 100,
        titleTextStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColor.bgButton,
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: SvgPicture.asset(
          "assets/images/dummy_form_aspirasi.svg",fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
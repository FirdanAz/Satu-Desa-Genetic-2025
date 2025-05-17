import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SvgPicture.asset('assets/images/onboarding_ilustration.svg', width: 270,),
          SizedBox(
            height: 16,
          ),
          Text(
            "Digitalisasi Desa,\nUntuk Warga, Oleh Warga!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppColor.titleText),
          ),
          SizedBox(height: 16,),
          Text(
            "Aplikasi terpadu untuk pelayanan desa\nmodern, transparan, dan partisipatif berbasis\n kebutuhan warga.",
            textAlign: TextAlign.center,
            
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: AppColor.descText, letterSpacing: 0, height: 0),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class InfoEmptyWidget extends StatelessWidget {
  const InfoEmptyWidget({super.key, required this.emptyText});
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            'assets/lotties/lottie_empty.json',
            frameRate: FrameRate(60),
            width: 200,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Belum ada $emptyText disini",
            style: TextStyle(fontSize: 13, color: AppColor.descText),
          )
        ],
      ),
    );
  }
}

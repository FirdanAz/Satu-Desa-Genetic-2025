import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({
    super.key,
    required this.bgColor,
    required this.titleColor,
    required this.title,
    required this.isLoad,
    this.svgAsset,
    this.onPress,
    this.titleSize
  });
  Color bgColor;
  Color titleColor;
  String title;
  String? svgAsset;
  VoidCallback? onPress;
  bool isLoad;
  double? titleSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: TextButton.styleFrom(
          foregroundColor: titleColor,
          backgroundColor: bgColor,
          disabledForegroundColor: Colors.red,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: svgAsset != null
                ? BorderSide(width: 1, color: AppColor.descText)
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        onPressed: onPress,
        child: svgAsset != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(svgAsset!),
                  SizedBox(width: 12.0),
                  Text(title, style: TextStyle(color: titleColor))
                ],
              )
            : isLoad
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.asset('assets/lotties/lottie_loading.json' ),
                      Text(title, style: TextStyle(color: titleColor))
                    ],
                  )
                : Text(title, style: TextStyle(color: titleColor, fontSize: titleSize)),
      ),
    );
  }
}

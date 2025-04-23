import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/login/views/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isWhite = true;

  void _listener(BuildContext context) {
    Timer(const Duration(milliseconds: 4000), () {
      // setState(() {
      //   _isWhite = false;
      // });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _isWhite
        ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor: AppColor.primary,
            statusBarColor: AppColor.primary,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light))
        : SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            statusBarColor: Colors.black38,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light));

    _listener(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: _isWhite
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    AppColor.secondary,
                    AppColor.primary
                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
                  tileMode: TileMode.clamp,
                ),
              )
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 120),
            SvgPicture.asset(
              _isWhite
                  ? 'assets/images/logo_white.svg'
                  : 'assets/images/logo_primary.svg',
              height: 190,
            ),
            SizedBox(height: 20),
            Text(
              "SATU DESA",
              style: TextStyle(
                  color: _isWhite ? Colors.white : AppColor.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Sistem Aspirasi Terpadu\n untuk Desa",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _isWhite ? Colors.white : AppColor.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

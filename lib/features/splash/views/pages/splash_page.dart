import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/core/widgets/snackbar.dart';
import 'package:satu_desa/features/bottom_navigation/views/bottom_navigation.dart';
import 'package:satu_desa/features/bottom_navigation/views/home_nav_wrapper.dart';
import 'package:satu_desa/features/home_page/views/pages/home_page.dart';
import 'package:satu_desa/features/login/views/pages/login_page.dart';
import 'package:satu_desa/features/splash/cubit/splash_screen_cubit.dart';
import 'package:satu_desa/features/splash/views/pages/on_boarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final bool _isWhite = true;

  void _listener(BuildContext context, SplashScreenState state) {
    if (state.status == SplashScreenStateStatus.failed) {
      showSnackBar(
        context,
        duration: const Duration(seconds: 3),
        color: Colors.red,
        content: Row(
          children: [
            const Icon(Icons.close, color: AppColor.bgButton, size: 18),
            const SizedBox(width: 15),
            Text("${state.errorMessage}, buka ulang aplikasi!"),
          ],
        ),
      );
      return;
    }

    Timer(
      const Duration(milliseconds: 500),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              (state.status == SplashScreenStateStatus.loggedIn)
                  ? const HomeNavWrapper()
                  : const OnBoardingPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = SplashScreenCubit()..init();
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<SplashScreenCubit, SplashScreenState>(
        bloc: cubit,
        listener: _listener,
        child: Container(
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:satu_desa/features/splash/views/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Satu Desa',
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}

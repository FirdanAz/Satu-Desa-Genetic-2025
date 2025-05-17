import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:satu_desa/core/bloc/provider.dart';
import 'package:satu_desa/features/splash/views/pages/splash_page.dart';

Future<void> main() async {
  await initializeDateFormatting('id_ID');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: Provider.providers(),
      child: MaterialApp(
        title: 'Satu Desa',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Goli',
        ),
        home: const SplashPage(),
      ),
    );
  }
}

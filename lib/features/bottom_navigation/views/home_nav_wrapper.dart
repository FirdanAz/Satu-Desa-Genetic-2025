import 'package:flutter/material.dart';
import 'package:satu_desa/core/public/function.dart';
import 'package:satu_desa/features/agenda_desa/views/pages/agenda_desa.dart';
import 'package:satu_desa/features/aspiration/views/pages/aspiration_page.dart';
import 'package:satu_desa/features/bottom_navigation/views/bottom_navigation.dart';
import 'package:satu_desa/features/home_page/views/pages/home_page.dart';
import 'package:satu_desa/features/musyawarah/views/pages/musyawarah_page.dart';

class HomeNavWrapper extends StatefulWidget {
  const HomeNavWrapper({super.key, this.selectedIndex});
  final int? selectedIndex;

  @override
  State<HomeNavWrapper> createState() => _HomeNavWrapperState();
}

class _HomeNavWrapperState extends State<HomeNavWrapper> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.selectedIndex != null) {
      _selectedIndex = widget.selectedIndex!;
    }
  }

  final List<Widget> _pages = const [
    HomePage(),
    AspirationPage(),
    AgendaDesa(),
    MusyawarahPage(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    PublicFunction().setSystemUiOverlay(Colors.white, Colors.white, Brightness.dark);
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onNavTapped,
      ),
    );
  }
}

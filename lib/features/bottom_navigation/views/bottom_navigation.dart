import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(
        label: "Beranda",
        iconPath: "assets/icons/ic_home.svg",
      ),
      _NavItem(
        label: "Aspirasi",
        iconPath: "assets/icons/ic_aspirasi.svg",
      ),
      _NavItem(
        label: "Agenda Desa",
        iconPath: "assets/icons/ic_agenda_desa.svg",
      ),
      _NavItem(
        label: "Musyawarah",
        iconPath: "assets/icons/ic_musyawarah.svg",
      ),
    ];

    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isActive = selectedIndex == index;
          final color = isActive ? AppColor.primary : AppColor.primary.withOpacity(0.5);
      
          return GestureDetector(
            onTap: () => onItemTapped(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  item.iconPath,
                  width: 26,
                  height: 26,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    color: color,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String iconPath;

  _NavItem({required this.label, required this.iconPath});
}

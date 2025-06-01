import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/profile/views/widgets/profile_menu_item_widget.dart';

class VillageInfoWidget extends StatelessWidget {
  const VillageInfoWidget({super.key, required this.title, required this.kodeDesa});
  final String title;
  final String kodeDesa;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileMenuItemWidget(
          title: title,
        ),
        kodeDesa != "" ? Row(
          children: [
            Text('Kode Desa: ', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
            Spacer(),
            Text(kodeDesa, style: TextStyle(color: AppColor.primary),),
            SizedBox(width: 10,),
            Icon(Icons.copy, size: 16),
          ],
        ) : Container(),
      ],
    );
  }
}

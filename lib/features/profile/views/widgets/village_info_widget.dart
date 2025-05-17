import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/profile/views/widgets/profile_menu_item_widget.dart';

class VillageInfoWidget extends StatelessWidget {
  const VillageInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileMenuItemWidget(
          title: 'Desa Maju, RT01 RW10, Kec. Jaya, Kab. Lancar',
        ),
        Row(
          children: const [
            Text('Kode Desa: ', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
            Spacer(),
            Text('XA81 AK09 763K', style: TextStyle(color: AppColor.descText),),
            SizedBox(width: 10,),
            Icon(Icons.copy, size: 16),
          ],
        ),
      ],
    );
  }
}

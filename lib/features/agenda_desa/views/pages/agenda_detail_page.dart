import 'package:flutter/material.dart';
import 'package:satu_desa/core/public/widgets/custom_appbar.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class AgendaDetailPage extends StatelessWidget {
  const AgendaDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PublicWidget().customAppBar(title: "", context: context),
      backgroundColor: AppColor.bgButton,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          width: double.maxFinite,
          child: Image.asset('assets/images/mock_agenda_detail.png', fit: BoxFit.fitWidth,)),
      ),
    );
  }
}

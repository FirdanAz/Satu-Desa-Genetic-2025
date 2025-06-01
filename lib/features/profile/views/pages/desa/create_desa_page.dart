import 'package:flutter/material.dart';
import 'package:satu_desa/core/public/widgets/custom_appbar.dart';
import 'package:satu_desa/core/public/widgets/custom_text_field.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class CreateDesaPage extends StatelessWidget {
  const CreateDesaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _namaDesaController = TextEditingController();
    final TextEditingController _alamatDesaController = TextEditingController();

    return Scaffold(
      appBar: PublicWidget().customAppBar(title: "Buat Desa", context: context),
      backgroundColor: Colors.white,
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColor.primary,
                  disabledForegroundColor: Colors.red,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: AppColor.descText),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Buat Desa",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              CustomTextFieldWidget(
                controller: _namaDesaController,
                title: "Nama Desa",
                hint: "Contoh : Samirejo",
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFieldWidget(
                controller: _namaDesaController,
                title: "Alamat Desa",
                hint: "Contoh : Samirejo Rw 5, Dukuh waringin",
              )
            ],
          ),
        ),
      ),
    );
  }
}

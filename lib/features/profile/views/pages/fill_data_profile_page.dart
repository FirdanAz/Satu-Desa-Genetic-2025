import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:satu_desa/core/public/widgets/custom_appbar.dart';
import 'package:satu_desa/core/public/widgets/custom_text_field.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/profile/cubit/profile_cubit.dart';
import 'package:satu_desa/features/profile/views/pages/fill_data_address_page.dart';

class FillDataProfilePage extends StatefulWidget {
  const FillDataProfilePage(
      {super.key, this.kartuKeluarga, this.nomorInduk, this.nomorTelp});
  final String? kartuKeluarga;
  final String? nomorInduk;
  final String? nomorTelp;

  @override
  State<FillDataProfilePage> createState() => _FillDataProfilePageState();
}

class _FillDataProfilePageState extends State<FillDataProfilePage> {
  final TextEditingController kartuKeluargaController = TextEditingController();
  final TextEditingController nomorIndukController = TextEditingController();
  final TextEditingController nomorTelpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    kartuKeluargaController.text = widget.kartuKeluarga ?? '';
    nomorIndukController.text = widget.nomorInduk ?? '';
    nomorTelpController.text = widget.nomorTelp ?? '';
  }

  @override
  void dispose() {
    kartuKeluargaController.dispose();
    nomorIndukController.dispose();
    nomorTelpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PublicWidget().customAppBar(
          title: kartuKeluargaController.text != ""
              ? "Edit Profile"
              : "Lengkapi Profil",
          context: context),
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
                onPressed: () {
                  if (kartuKeluargaController.text.isNotEmpty &&
                      nomorIndukController.text.isNotEmpty &&
                      nomorTelpController.text.isNotEmpty) {
                    final isEditing = widget.kartuKeluarga != null;

                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      title: isEditing ? "Update data?" : "Data sudah sesuai?",
                      text: isEditing
                          ? "Apakah Anda yakin ingin memperbarui data ini?"
                          : "Pastikan data yang diisi sudah sesuai",
                      confirmBtnText: isEditing ? "Update" : "Sudah",
                      confirmBtnColor: AppColor.primary,
                      onConfirmBtnTap: () async {
                        if (Navigator.canPop(context)) Navigator.pop(context);

                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.loading,
                            text:
                                isEditing ? "Memperbarui..." : "Menyimpan...");

                        await Future.delayed(Duration(seconds: 2));

                        if (isEditing) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    ProfileCubit()..fetchProvinces(),
                                child: FillDataAddressPage(
                                  kartuKeluarga: kartuKeluargaController.text,
                                  nomorInduk: nomorIndukController.text,
                                  nomorTelp: nomorTelpController.text,
                                  isEditing: true,
                                ),
                              ),
                            ),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    ProfileCubit()..fetchProvinces(),
                                child: FillDataAddressPage(
                                  kartuKeluarga: kartuKeluargaController.text,
                                  nomorInduk: nomorIndukController.text,
                                  nomorTelp: nomorTelpController.text,
                                  isEditing: false,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.info,
                      title: "Data ada yang kosong",
                      text: "Periksa kembali formulir anda",
                      confirmBtnColor: AppColor.redIcon,
                      showConfirmBtn: false,
                    );
                  }
                },
                child: Text(
                  "Simpan & Lanjut",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Data Penduduk",
                style: TextStyle(
                    color: AppColor.titleText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFieldWidget(
                controller: kartuKeluargaController,
                title: "Kartu Keluarga (KK)",
                type: TextInputType.number,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFieldWidget(
                controller: nomorIndukController,
                title: "Nomor Induk Keluarga (NIK)",
                type: TextInputType.number,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFieldWidget(
                controller: nomorTelpController,
                title: "Nomor Telepon",
                type: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

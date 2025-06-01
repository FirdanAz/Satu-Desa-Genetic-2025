import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:satu_desa/core/public/shimmer/shimmer_fill_data.dart';
import 'package:satu_desa/core/public/widgets/custom_appbar.dart';
import 'package:satu_desa/core/public/widgets/info_empty_widget.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/bottom_navigation/views/home_nav_wrapper.dart';
import 'package:satu_desa/features/profile/cubit/profile_cubit.dart';
import 'package:satu_desa/features/profile/models/location_model.dart';
import 'package:satu_desa/features/profile/models/village_model.dart';
import 'package:satu_desa/features/profile/views/widgets/wilayah_dropdown_widget.dart';

class FillDataAddressPage extends StatefulWidget {
  const FillDataAddressPage(
      {super.key,
      required this.kartuKeluarga,
      required this.nomorInduk,
      required this.nomorTelp,
      required this.isEditing});
  final String kartuKeluarga;
  final String nomorInduk;
  final String nomorTelp;
  final bool isEditing;

  @override
  State<FillDataAddressPage> createState() => _FillDataAddressPageState();
}

class _FillDataAddressPageState extends State<FillDataAddressPage> {
  DatumLocation? selectedProvince;
  DatumLocation? selectedRegency;
  DatumLocation? selectedDistrict;
  DatumVillage? selectedVillage;

  @override
  void initState() {
    super.initState();
    try {
      debugPrint("Mencoba fetch provinces...");
      context.read<ProfileCubit>().fetchProvinces();
    } catch (e) {
      debugPrint("Gagal fetch karena cubit tidak ditemukan: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PublicWidget()
          .customAppBar(title: "Lengkapi Profil - Alamat", context: context),
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
                onPressed: () {
                  if (selectedProvince != null &&
                      selectedRegency != null &&
                      selectedDistrict != null &&
                      selectedVillage != null) {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.confirm,
                        animType: QuickAlertAnimType.scale,
                        title: "Data sudah sesuai?",
                        text: "Pastikan data yang diisi sudah sesuai",
                        confirmBtnText: "Sudah",
                        confirmBtnTextStyle:
                            TextStyle(fontSize: 14, color: Colors.white),
                        onConfirmBtnTap: () async {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.loading,
                              animType: QuickAlertAnimType.scale,
                              text: "Menyimpan...");
                          await Future.delayed(Duration(seconds: 2));
                          context.read<ProfileCubit>().fillDataUser(
                              kartuKeluarga: widget.kartuKeluarga,
                              nomorInduk: widget.nomorInduk,
                              nomorTelp: widget.nomorTelp,
                              address:
                                  "${selectedVillage!.name} ${selectedDistrict!.name} ${selectedRegency!.name}",
                              provinsi: selectedProvince!.name,
                              kabupaten: selectedRegency!.name,
                              kecamatan: selectedDistrict!.name,
                              desa: selectedVillage!.name);
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeNavWrapper()),
                            (route) => false,
                          );
                        },
                        confirmBtnColor: AppColor.primary);
                  } else {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.info,
                        text: "periksa kembali formulir anda",
                        animType: QuickAlertAnimType.scale,
                        confirmBtnColor: AppColor.redIcon,
                        title: "Data ada yang kosong",
                        showConfirmBtn: false);
                  }
                },
                child: Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) {
            return ShimmerFillData();
          } else if (state.status == ProfileStatus.failed) {
            return Container(
              child: Center(
                child: InfoEmptyWidget(
                    emptyText: "Ups!! ada error\n ${state.errorMessage}"),
              ),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Alamat Lengkap",
                    style: TextStyle(
                        color: AppColor.titleText,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  WilayahDropdownWidget(
                    label: "Provinsi",
                    value: selectedProvince,
                    items: state.provinces != null ? state.provinces!.data : [],
                    getLabel: (p0) => p0.name,
                    onChanged: (p0) {
                      setState(() {
                        selectedProvince = p0;
                        selectedRegency = null;
                        selectedDistrict = null;
                        selectedVillage = null;
                      });
                      context.read<ProfileCubit>().fetchRegencies(p0!.code);
                    },
                  ),
                  WilayahDropdownWidget(
                    label: "Kabupaten",
                    value: selectedRegency,
                    items: state.kabupaten?.data ?? [],
                    getLabel: (p0) => p0.name,
                    isEnabled: (state.kabupaten?.data.isNotEmpty ?? false),
                    onChanged: (p0) {
                      setState(() {
                        selectedRegency = p0;
                        selectedDistrict = null;
                        selectedVillage = null;
                      });
                      context.read<ProfileCubit>().fetchDistricts(p0!.code);
                    },
                  ),
                  WilayahDropdownWidget(
                    label: "Kecamatan",
                    value: selectedDistrict,
                    items: state.kecamatan?.data ?? [],
                    getLabel: (p0) => p0.name,
                    isEnabled: (state.kecamatan?.data.isNotEmpty ?? false),
                    onChanged: (p0) {
                      setState(() {
                        selectedDistrict = p0;
                        selectedVillage = null;
                      });
                      context.read<ProfileCubit>().fetchVillages(p0!.code);
                    },
                  ),
                  WilayahDropdownWidget(
                    label: "Desa/Kelurahan",
                    value: selectedVillage,
                    items: state.desa?.data ?? [],
                    getLabel: (p0) => "${p0.name}",
                    isEnabled: (state.desa?.data.isNotEmpty ?? false),
                    onChanged: (p0) {
                      setState(() {
                        selectedVillage = p0;
                      });
                    },
                  ),
                  Text("Kode Pos"),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.descText),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      selectedVillage?.postalCode != null
                          ? selectedVillage!.postalCode
                          : "Pilih desa",
                      style: TextStyle(color: AppColor.descText),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

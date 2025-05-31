import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/core/widgets/snackbar.dart';
import 'package:satu_desa/features/bottom_navigation/views/home_nav_wrapper.dart';
import 'package:satu_desa/features/join_desa/cubit/join_desa_cubit.dart';
import 'package:satu_desa/features/join_desa/views/pages/help_kode_desa_page.dart';

class JoinDesaPage extends StatefulWidget {
  const JoinDesaPage({super.key});

  @override
  State<JoinDesaPage> createState() => _JoinDesaPageState();
}

class _JoinDesaPageState extends State<JoinDesaPage> {
  final TextEditingController _kodeController = TextEditingController();

  @override
  void dispose() {
    _kodeController.dispose();
    super.dispose();
  }

  void _submitKode() {
    final kode = _kodeController.text.trim();
    if (kode.isEmpty) {
      print(kode);
    } else {
      print(_kodeController.text.replaceAll(' ', '').trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JoinDesaCubit, JoinDesaState>(
      listener: (context, state) {
        if (state.status == JoinDesaStatus.loading) {
          QuickAlert.show(
              context: context,
              type: QuickAlertType.loading,
              text: "Loading");
        } else if (state.status == JoinDesaStatus.isMyRequest) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.info,
            text: "Tunggu verifikasi dari pengelola",
            barrierDismissible: false,
            title: "Anda Memiliki Permintaan yang sedang diproses",
            confirmBtnText: "Selesai",
            onConfirmBtnTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeNavWrapper(),
              ),
              (route) => false,
            ),
          );
        } else if (state.status == JoinDesaStatus.success) {
          QuickAlert.show(context: context, type: QuickAlertType.success);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeNavWrapper(),
            ),
            (route) => false,
          );
        } else if (state.status == JoinDesaStatus.failed) {
          showErrorSnackBar(context, state.errorMessage!);
        }
      },
      child: BlocBuilder<JoinDesaCubit, JoinDesaState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            bottomSheet: Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, bottom: 40),
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
                          side:
                              BorderSide(width: 1, color: AppColor.descText),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onPressed: () {
                        if (_kodeController.text.isNotEmpty) {
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              animType: QuickAlertAnimType.scale,
                              title: "Kode Desa sudah sesuai?",
                              text: "Pastikan kode desa sudah sesuai",
                              confirmBtnText: "Sudah",
                              confirmBtnTextStyle: TextStyle(
                                  fontSize: 14, color: Colors.white),
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
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                                context
                                    .read<JoinDesaCubit>()
                                    .postJoin(kodeDesa: _kodeController.text.replaceAll(' ', '').trim());
                              },
                              confirmBtnColor: AppColor.primary);
                        } else {
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.info,
                              text: "periksa kembali formulir anda",
                              animType: QuickAlertAnimType.scale,
                              confirmBtnColor: AppColor.redIcon,
                              title: "kode desa harus diisi",
                              showConfirmBtn: false);
                        }
                      },
                      child: Text(
                        "Hubungkan",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ),
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: false,
                  leading: null,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(50),
                    child: Container(
                      height: 35,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40)),
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [AppColor.secondary, AppColor.primary],
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/images/bg_auth.svg',
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/logo_white.svg',
                                    width: 48,
                                  ),
                                  const SizedBox(width: 14),
                                  const Text(
                                    'SATU DESA',
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 38),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
    
                // === Konten Form Kode Desa ===
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Masukkan Kode Desa Anda!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.titleText,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Masukkan kode desa anda untuk terhubung langsung dengan pemerintah desa anda.",
                          style: TextStyle(
                            color: AppColor.descText,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: TextFormField(
                            controller: _kodeController,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              letterSpacing: 3,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[A-Za-z0-9]')),
                              LengthLimitingTextInputFormatter(
                                  12), // 3 blok x 4 char + 2 spasi
                              KodeDesaInputFormatter(), // <-- Formatter custom
                            ],
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'FNFN 1212 2323',
                                hintStyle: TextStyle(
                                    color:
                                        AppColor.descText.withOpacity(0.5))),
                          ),
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HelpKodeDesaPage(),
                              )),
                          child: Row(
                            children: const [
                              Icon(Icons.info_outline,
                                  size: 18, color: Colors.grey),
                              SizedBox(width: 5),
                              Text(
                                "Cara Mendapatkan Kode Desa",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class KodeDesaInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Hapus semua spasi
    final rawText = newValue.text.replaceAll(' ', '');

    // Pisah setiap 4 karakter
    final buffer = StringBuffer();
    for (int i = 0; i < rawText.length; i++) {
      buffer.write(rawText[i]);
      if ((i + 1) % 4 == 0 && i != rawText.length - 1) {
        buffer.write(' ');
      }
    }

    final formattedText = buffer.toString();

    // Kembalikan dengan posisi kursor yang disesuaikan
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satu_desa/core/public/shimmer/shimmer_profile_page.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/core/widgets/snackbar.dart';
import 'package:satu_desa/features/profile/cubit/profile_cubit.dart';
import 'package:satu_desa/features/profile/views/pages/change_password_page.dart';
import 'package:satu_desa/features/profile/views/pages/edit_profile_page.dart';
import 'package:satu_desa/features/profile/views/widgets/additional_info_widget.dart';
import 'package:satu_desa/features/profile/views/widgets/profile_header_widget.dart';
import 'package:satu_desa/features/profile/views/widgets/profile_menu_item_widget.dart';
import 'package:satu_desa/features/profile/views/widgets/section_tile_widget.dart';
import 'package:satu_desa/features/profile/views/widgets/village_info_widget.dart';
import 'package:satu_desa/features/splash/views/pages/splash_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final LocalDataPersistance _localData = LocalDataPersistance();

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  void _profileListener(BuildContext context, ProfileState state) {
    final Size screenSize = MediaQuery.sizeOf(context);
    if (state.status == ProfileStatus.loading) {
      showDialog(
          context: context,
          builder: (context) => Dialog.fullscreen(
                child: ShimmerProfilePage(),
              ));
    } else if (state.status == ProfileStatus.success) {
      if (state.profileModel!.userProfile == null) {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.noHeader,
                animType: AnimType.rightSlide,
                title: 'Profile Belum Lengkap',
                desc: 'Lengkapi Profile untuk memudahkan valisadi',
                btnOkOnPress: () {},
                btnOkText: "Lengkapi",
                btnOkColor: AppColor.primary)
            .show();
      }
    } else if (state.status == ProfileStatus.logOutSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SplashPage()),
        (route) => false,
      );
    } else if (state.status == ProfileStatus.failed) {
      Navigator.pop(context);
      showErrorSnackBar(context, state.errorMessage!);
    }
  }

  Future<void> _logoutDialog(BuildContext c) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text('Konfirmasi', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Anda yakin ingin keluar dari akun?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () async {
                Navigator.pop(context);
                await Future.delayed(Duration(milliseconds: 200));
                await c.read<ProfileCubit>().postLogout();
              },
              child: Text('Keluar'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profil'),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          toolbarHeight: 100,
          titleTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColor.primary),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.primary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Colors.white,
        body: BlocListener<ProfileCubit, ProfileState>(
          listener: _profileListener,
          bloc: context.read<ProfileCubit>(),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state.status == ProfileStatus.loading) {
                return ShimmerProfilePage();
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ProfileHeaderWidget(
                              username: _localData.getUserName() != null
                                  ? _localData.getUserName().toString()
                                  : "User",
                              userNik: _localData.getUserNik() != null
                                  ? _localData.getUserNik().toString()
                                  : "",
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: AdditionalInfoWidget(),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        children: [
                          Divider(),
                          SectionTitleWidget(title: 'Desa'),
                          VillageInfoWidget(),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(),
                          SectionTitleWidget(title: 'Pengaturan Akun'),
                          ProfileMenuItemWidget(
                            title: 'Profil Akun',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(),
                              ),
                            ),
                          ),
                          ProfileMenuItemWidget(
                            title: 'Ganti Password',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangePasswordPage(),
                              ),
                            ),
                          ),
                          Divider(),
                          SectionTitleWidget(title: 'Pusat Bantuan'),
                          ProfileMenuItemWidget(
                            title: 'FAQ/Tanya Jawab',
                          ),
                          ProfileMenuItemWidget(title: 'Kontak Admin Desa'),
                          Divider(),
                          SectionTitleWidget(title: 'Sekretaris Desa'),
                          ProfileMenuItemWidget(title: 'Buat Desa'),
                          Divider(),
                          SizedBox(
                            height: 20,
                          ),
                          ProfileMenuItemWidget(
                            title: 'Keluar',
                            onTap: () => _logoutDialog(context),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}

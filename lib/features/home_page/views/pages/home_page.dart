import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:satu_desa/core/constant/constant.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/bayar_sampah/views/pages/bayar_sampah_page.dart';
import 'package:satu_desa/features/dana_desa/views/pages/dana_desa_page.dart';
import 'package:satu_desa/features/home_page/views/widgets/card_agenda_desa_widget.dart';
import 'package:satu_desa/features/home_page/views/widgets/card_anggaran_widget.dart';
import 'package:satu_desa/features/home_page/views/widgets/menu_home_page_widget.dart';
import 'package:satu_desa/features/home_page/views/widgets/notification_button_widget.dart';
import 'package:satu_desa/core/public/shimmer/shimmer_home_page.dart';
import 'package:satu_desa/features/home_page/views/widgets/title_text_menu_widget.dart';
import 'package:satu_desa/features/join_desa/cubit/join_desa_cubit.dart';
import 'package:satu_desa/features/join_desa/views/pages/join_desa_page.dart';
import 'package:satu_desa/features/profile/cubit/profile_cubit.dart';
import 'package:satu_desa/features/profile/views/pages/fill_data_profile_page.dart';
import 'package:satu_desa/features/profile/views/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalDataPersistance _localData = LocalDataPersistance();
  bool userProfile = true;

  @override
  void initState() {
    super.initState();
  }

  _showDialogNullProfile() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: 'Profil belum lengkap',
        text: 'Lengkapi Profil untuk memudahkan validasi',
        confirmBtnTextStyle: TextStyle(fontSize: 12, color: Colors.white),
        onConfirmBtnTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FillDataProfilePage(),
              ));
        },
        confirmBtnText: "Gabung & Lengkapi",
        confirmBtnColor: AppColor.primary);
  }

  _showDialogNullDesa() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: 'Belum Memiliki Desa',
        text: 'Dapatkan Kode Desa Anda di Pengelola Setempat',
        confirmBtnTextStyle: TextStyle(fontSize: 12, color: Colors.white),
        onConfirmBtnTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => JoinDesaPage(),
            ),
            (route) => false,
          );
        },
        confirmBtnText: "Gabung & Lengkapi",
        confirmBtnColor: AppColor.primary);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.green, // ✅ Ganti dengan warna yang diinginkan
          statusBarIconBrightness:
              Brightness.light, // Ubah ke light/dark tergantung warna bg
          statusBarBrightness: Brightness.light),
    );
    return Scaffold(
        backgroundColor: AppColor.bgButton,
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          toolbarHeight: 5,
        ),
        body: BlocProvider(
          create: (context) => ProfileCubit()..getProfile(),
          child: BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state.profileModel!.userProfile == null) {
                _showDialogNullProfile();
              } else if (state.profileModel!.userProfile!.desaId == 0) {
                BlocListener<JoinDesaCubit, JoinDesaState>(
                  listener: (context, state) {
                    print(state.status);
                    if (state.status == JoinDesaStatus.isMyRequest) {
                      
                    } else {
                      _showDialogNullDesa();
                      return _showDialogNullDesa();
                    }
                  },
                );
              }
            },
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                print(state.profileModel);
                if (state.status == ProfileStatus.loading) {
                  return ShimmerHomePage();
                } else {
                  return CustomScrollView(
                    physics: ClampingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          height: 305,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Color(0xFF6DB389),
                                Color(0xFF3F7D58)
                              ],
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                          child: SafeArea(
                            child: Stack(
                              fit: StackFit.passthrough,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/bg_auth.svg',
                                  fit: BoxFit.fitWidth,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BlocProvider(
                                                    create: (context) =>
                                                        ProfileCubit()
                                                          ..getProfile(),
                                                    child: ProfilePage(),
                                                  ),
                                                )),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 21,
                                                  backgroundImage: state
                                                                  .profileModel!
                                                                  .userProfile !=
                                                              null &&
                                                          state
                                                                  .profileModel!
                                                                  .userProfile!
                                                                  .profilePicture !=
                                                              ""
                                                      ? NetworkImage(
                                                          "${Constant.baseUrlImage}${state.profileModel!.userProfile!.profilePicture}",
                                                        )
                                                      : AssetImage(
                                                          "assets/icons/ic_avatar.png"),
                                                ),
                                                const SizedBox(width: 14),
                                                Text(
                                                  'Selamat Pagi\n${_localData.getUserName()}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          NotificationButtonWidget(
                                              onPressed: () {})
                                        ],
                                      ),
                                      const SizedBox(height: 30),
                                      Container(
                                        height: 160,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                          border: Border.all(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(19),
                                        ),
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              width: double.maxFinite,
                                              height: double.maxFinite,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                  'assets/images/bg_home_slider.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: double.maxFinite,
                                              width: double.maxFinite,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 12),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/logo_desa.png',
                                                        width: 38,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 6,
                                                      ),
                                                      Text(
                                                        "Desa Maju",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    "Digitalisasi Desa,\nUntuk Warga, Oleh Warga!",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MenuHomePageWidget(
                                    title: "Bayar\nSampah",
                                    iconAsset:
                                        "assets/icons/ic_bayar_sampah.svg",
                                    onTap: () =>
                                        state.profileModel!.userProfile != null
                                            ? state.profileModel!.userProfile!
                                                        .desaId !=
                                                    0
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          BayarSampahPage(),
                                                    ))
                                                : _showDialogNullDesa()
                                            : _showDialogNullProfile(),
                                  ),
                                  MenuHomePageWidget(
                                    title: "Dana\nDesa",
                                    iconAsset: "assets/icons/ic_dana_desa.svg",
                                    onTap: () =>
                                        state.profileModel!.userProfile != null
                                            ? state.profileModel!.userProfile!
                                                        .desaId !=
                                                    0
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DanaDesaPage(),
                                                    ))
                                                : _showDialogNullDesa()
                                            : _showDialogNullProfile(),
                                  ),
                                  MenuHomePageWidget(
                                      title: "Kabar\nDesa",
                                      iconAsset:
                                          "assets/icons/ic_kabar_desa.svg"),
                                  MenuHomePageWidget(
                                      title: "Layanan\nSurat",
                                      iconAsset:
                                          "assets/icons/ic_layanan_surat.svg"),
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              textMenuTitle("Dana Desa"),
                              SizedBox(
                                height: 14,
                              ),
                              CardAnggaranWidget(
                                  totalAnggaran: 1200000000,
                                  anggaranTerpakai: 240000000),
                              SizedBox(
                                height: 18,
                              ),
                              textMenuTitle("Agenda Desa"),
                              SizedBox(
                                height: 14,
                              ),
                              CardAgendaDesaWidget(),
                              Container(
                                height: 200,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ));
  }
}

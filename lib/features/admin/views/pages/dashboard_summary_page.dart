import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:satu_desa/core/constant/constant.dart';
import 'package:satu_desa/core/public/shimmer/shimmer_dashboard_card.dart';
import 'package:satu_desa/core/public/shimmer/shimmer_home_page.dart';
import 'package:satu_desa/core/public/widgets/info_empty_widget.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/admin/cubit/admin_cubit.dart';
import 'package:satu_desa/features/home_page/views/widgets/notification_button_widget.dart';
import 'package:satu_desa/features/profile/cubit/profile_cubit.dart';

class DashboardSummaryPage extends StatefulWidget {
  const DashboardSummaryPage({super.key});

  @override
  State<DashboardSummaryPage> createState() => _DashboardSummaryPageState();
}

class _DashboardSummaryPageState extends State<DashboardSummaryPage> {
  final LocalDataPersistance _localData = LocalDataPersistance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 6,
        backgroundColor: AppColor.primary,
      ),
      backgroundColor: AppColor.bgButton,
      body: BlocProvider(
        create: (context) => ProfileCubit()..getProfile(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.status == ProfileStatus.loading) {
              return ShimmerHomePage();
            } else if (state.status == ProfileStatus.success) {
              return BlocProvider(
                create: (context) => AdminCubit()..getSummaryDashboard(),
                child: BlocBuilder<AdminCubit, AdminState>(
                  builder: (context, adminState) {
                    return CustomScrollView(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
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
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                            border: Border.all(
                                                color: Colors.white
                                                    .withOpacity(0.3),
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
                                                    horizontal: 16,
                                                    vertical: 12),
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
                                                              color:
                                                                  Colors.white,
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
                        adminState.status == AdminStatus.loading
                            ? SliverToBoxAdapter(
                                child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: Center(child: ShimmerDashboardCard()),
                              ))
                            : adminState.status == AdminStatus.success
                                ? SliverToBoxAdapter(
                                    child: GridView.count(
                                      crossAxisCount: 2,
                                      shrinkWrap: true,
                                      childAspectRatio: 1.5,
                                      physics: NeverScrollableScrollPhysics(),
                                      mainAxisSpacing: 19,
                                      crossAxisSpacing: 16,
                                      padding: EdgeInsets.all(30),
                                      children: [
                                        _StatCard(
                                            icon: Icons.group,
                                            value: adminState
                                                .profileModel!.data.totalWarga
                                                .toString(),
                                            label: 'Warga Terdaftar'),
                                        _StatCard(
                                            icon: Icons.delete,
                                            value: adminState.profileModel!.data
                                                .retribusiLabel,
                                            label: 'Retribusi Sampah',
                                            isLabel: true),
                                        _StatCard(
                                            icon: Icons.article,
                                            value: adminState.profileModel!.data
                                                .permohonanSurat
                                                .toString(),
                                            label: 'Permohonan Surat'),
                                        _StatCard(
                                            icon: Icons.account_balance_wallet,
                                            value: 'Kelola',
                                            label: adminState.profileModel!.data
                                                .danaDesaLabel,
                                            isLabel: true),
                                        _StatCard(
                                            icon: Icons.campaign,
                                            value: adminState
                                                .profileModel!.data.aspirasi
                                                .toString(),
                                            label: 'Aspirasi'),
                                        _StatCard(
                                            icon: Icons.how_to_vote,
                                            value: adminState
                                                .profileModel!.data.musyawarah
                                                .toString(),
                                            label: 'Musyawarah'),
                                        _StatCard(
                                            icon: Icons.event_note,
                                            value: adminState
                                                .profileModel!.data.agendaDesa
                                                .toString(),
                                            label: 'Agenda Desa'),
                                      ],
                                    ),
                                  )
                                : SliverToBoxAdapter()
                      ],
                    );
                  },
                ),
              );
            } else {
              return InfoEmptyWidget(emptyText: "Dashboard");
            }
          },
        ),
      ),
    );
  }

  Widget _StatCard(
      {required IconData icon,
      required String value,
      required String label,
      bool isLabel = false}) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(9),
                    child: Icon(icon, color: Colors.white, size: 28)),
                const SizedBox(width: 12),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isLabel ? FontWeight.w600 : FontWeight.bold,
                    color: isLabel ? AppColor.primary : AppColor.titleText,
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(label, style: TextStyle(fontSize: 12, color: AppColor.descText)),
          ],
        ),
      ),
    );
  }
}

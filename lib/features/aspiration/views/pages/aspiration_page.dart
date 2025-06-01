import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:readmore/readmore.dart';
import 'package:satu_desa/core/constant/constant.dart';
import 'package:satu_desa/core/public/function.dart';
import 'package:satu_desa/core/public/pages/photo_detail_page.dart';
import 'package:satu_desa/core/public/shimmer/shimmer_bayar_sampah_page.dart';
import 'package:satu_desa/core/public/widgets/app_bar_card_widget.dart';
import 'package:satu_desa/core/public/widgets/info_empty_widget.dart';
import 'package:satu_desa/core/public/widgets/list_tile_image_widget.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/features/aspiration/cubit/aspiration_cubit.dart';
import 'package:satu_desa/features/aspiration/views/pages/create_aspiration.dart';
import 'package:satu_desa/features/aspiration/views/widgets/custom_tabbar_widget.dart';
import 'package:satu_desa/features/bottom_navigation/views/home_nav_wrapper.dart';
import 'package:satu_desa/features/login/views/widgets/custom_button_widget.dart';

class AspirationPage extends StatefulWidget {
  const AspirationPage({super.key});

  @override
  State<AspirationPage> createState() => _AspirationPageState();
}

class _AspirationPageState extends State<AspirationPage> {
  final cubit = AspirationCubit()..getAspirasi();
  String? userId = LocalDataPersistance().getUserId();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabLabels = ['Aspirasi Warga', 'Aspirasi Saya'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        toolbarHeight: 5,
      ),
      backgroundColor: AppColor.bgButton,
      body: BlocBuilder<AspirationCubit, AspirationState>(
        bloc: cubit,
        builder: (context, state) {
          print(state.status);
          if (state.status == AspirationStatus.loading) {
            return ShimmerBayarSampahPage();
          } else if (state.status == AspirationStatus.success) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: AppBarCardWidget(
                  title: "Ayo Sampaikan keluhan atau ide anda.",
                  btnText: "Ajukan Aspirasi",
                  iconPath: "ic_btn_asprasi.png",
                  appBarTitle: "Aspirasi",
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AspirasiFormPage(),
                      )),
                )),
                SliverToBoxAdapter(
                    child: Column(
                  children: [
                    const SizedBox(height: 25),
                    CustomTabBarWidget(
                      labels: tabLabels,
                      selectedIndex: selectedIndex,
                      onTabSelected: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: IndexedStack(
                        index: selectedIndex,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              state.aspirasiModels!.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: state.aspirasiModels!.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        List<String> imageUrls = state
                                            .aspirasiModels![index].images
                                            .where((img) => img.path.isNotEmpty)
                                            .map((img) => img.path)
                                            .toList();
                                        return buildAspirasiCard(
                                            state, index, imageUrls, false);
                                      },
                                    )
                                  : Center(
                                      child: InfoEmptyWidget(
                                      emptyText: "Aspirasi",
                                    )),
                              SizedBox(
                                height: 39,
                              ),
                            ],
                          ),
                          Builder(
                            builder: (_) {
                              final myAspirasi = state.aspirasiModels!
                                  .where((item) =>
                                      item.user.id.toString() == userId)
                                  .toList();

                              return myAspirasi.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: myAspirasi.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final aspirasi = myAspirasi[index];
                                        final imageUrls = aspirasi.images
                                            .where((img) => img.path.isNotEmpty)
                                            .map((img) => img.path)
                                            .toList();
                                        return buildAspirasiCard(
                                            state,
                                            state.aspirasiModels!
                                                .indexOf(aspirasi),
                                            imageUrls,
                                            true);
                                      },
                                    )
                                  : Center(
                                      child: InfoEmptyWidget(
                                          emptyText: "Aspirasi Saya"));
                            },
                          )
                        ],
                      ),
                    )
                  ],
                )),
                // SliverToBoxAdapter(
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     itemCount: state.aspirasiModels!.length,
                //     itemBuilder: (context, index) {
                //       return AspirasiCard(data: state.aspirasiModels![index]);
                //     },
                //   ),
                // )
              ],
            );
          } else if (state.status == AspirationStatus.failed) {
            AwesomeDialog(
                context: context,
                animType: AnimType.scale,
                dialogType: DialogType.info,
                title: state.errorMessage);
            return Container();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget buildAspirasiCard(AspirationState state, int index,
      List<String> urlImages, bool isMyAspirasi) {
    var user = state.aspirasiModels![index].user;
    var aspirasi = state.aspirasiModels![index];

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 17,
                backgroundImage: isMyAspirasi &&
                        state.aspirasiModels![index].user.userProfile
                                .profilePicture !=
                            null
                    ? NetworkImage(
                        "${Constant.baseUrlImage}${state.aspirasiModels![index].user.userProfile.profilePicture}",
                      )
                    : user.userProfile.profilePicture != null &&
                            state.aspirasiModels![index].anonim == 0
                        ? NetworkImage(
                            "${Constant.baseUrlImage}${state.aspirasiModels![index].user.userProfile.profilePicture}",
                          )
                        : AssetImage("assets/icons/ic_avatar.png"),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Text(
                state.aspirasiModels![index].anonim == 0
                    ? user.name
                    : "anonim ${isMyAspirasi ? "(Anda)" : ""}",
                style: TextStyle(
                    fontSize: 13,
                    color: AppColor.descText,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              isMyAspirasi
                  ? Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AspirasiFormPage(
                                  existingAspirasi: aspirasi,
                                ),
                              )),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(6)),
                            child: Icon(
                              Icons.mode_edit_outline_outlined,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          onTap: () => QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              animType: QuickAlertAnimType.scale,
                              title: "Yakin Untuk menghapus",
                              text: "Hapus ${aspirasi.judul}?",
                              confirmBtnText: "Hapus",
                              onConfirmBtnTap: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }

                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.loading,
                                  animType: QuickAlertAnimType.scale,
                                  text: "Menghapus...",
                                );
                                context
                                    .read<AspirationCubit>()
                                    .deleteAspirasi(aspirasiId: aspirasi.id)
                                    .whenComplete(
                                      () => Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HomeNavWrapper(selectedIndex: 1,),
                                        ),
                                        (route) => false,
                                      ),
                                    );
                              },
                              showCancelBtn: false),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(6)),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container()
            ],
          ),
          urlImages.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhotoDetailPage(
                              imageUrls: urlImages,
                              initialIndex: 0,
                              heroTag: 'photo_${1}_1',
                            ),
                          )),
                      child: ListTileImageWidget(urlImages: urlImages)),
                )
              : Container(),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            aspirasi.judul,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 14.0,
          ),
          ReadMoreText(
            aspirasi.deskripsi,
            trimMode: TrimMode.Line,
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w400,
                color: AppColor.descText),
            trimLines: 3,
            trimCollapsedText: 'Lebih Lengkap',
            trimExpandedText: ' Lebih Sedikit',
            lessStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColor.primary,
            ),
            moreStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColor.primary,
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/ic_location.svg',
                // ignore: deprecated_member_use
                color: AppColor.redIcon,
                width: 15,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                aspirasi.lokasi,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColor.descText),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Tanggal diajukan",
            style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w400,
                color: AppColor.descText),
          ),
          const SizedBox(
            height: 9,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_date.svg',
                    // ignore: deprecated_member_use
                    color: Colors.black,
                    width: 15,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    PublicFunction().formatTanggal(aspirasi.createdAt),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColor.descText),
                  ),
                ],
              ),
              SizedBox(
                  height: 24,
                  child: CustomButtonWidget(
                    bgColor: aspirasi.status == 'diajukan'
                        ? Colors.blue
                        : aspirasi.status == 'diterima'
                            ? AppColor.primary
                            : aspirasi.status == 'ditolak'
                                ? Colors.red
                                : Colors.white,
                    titleColor: Colors.white,
                    title: aspirasi.status == 'diajukan'
                        ? "Diproses"
                        : aspirasi.status == 'diterima'
                            ? "Diterima"
                            : aspirasi.status == 'ditolak'
                                ? "Ditolak"
                                : "",
                    isLoad: false,
                    titleSize: 11,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

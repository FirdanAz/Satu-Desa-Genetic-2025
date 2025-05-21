import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satu_desa/core/public/shimmer/shimmer_home_page.dart';
import 'package:satu_desa/core/public/widgets/custom_list_tile.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/dana_desa/cubit/dana_desa_cubit.dart';
import 'package:satu_desa/features/dana_desa/views/pages/dana_desa_detail_page.dart';
import 'package:satu_desa/features/dana_desa/views/widgets/card_anggaran_widget.dart';

class DanaDesaPage extends StatefulWidget {
  const DanaDesaPage({super.key});

  @override
  State<DanaDesaPage> createState() => _DanaDesaPageState();
}

class _DanaDesaPageState extends State<DanaDesaPage> {
  final cubit = DanaDesaCubit()..getDanaDesa();

  String formatRupiah(int amount) {
    return 'Rp${amount.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dana Desa'),
        backgroundColor: AppColor.primary,
        toolbarHeight: 100,
        titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColor.bgButton,
      body: BlocBuilder<DanaDesaCubit, DanaDesaState>(
        bloc: cubit,
        builder: (context, state) {
          if (state.status == DanaDesaStatus.loading) {
            return ShimmerHomePage();
          } else if (state.status == DanaDesaStatus.failed) {
            AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                title: state.errorMessage);
          } else if (state.status == DanaDesaStatus.success) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardAnggaranWidget(
                      totalAnggaran: state
                          .danaDesaModel!.data.first.totalAmountValue
                          .toInt(),
                      anggaranTerpakai:
                          state.danaDesaModel!.data.first.usedAmount.toInt(),
                      tahunAnggaran: state.danaDesaModel!.data.first.year,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Rancangan Anggaran Belanja",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ListView.builder(
                      itemCount: state.danaDesaModel!.data.first.usages.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data =
                            state.danaDesaModel!.data.first.usages[index];

                        return Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DanaDesaDetailPage(
                                          dataUsage: data),
                                    )),
                                child: CustomListTile(
                                    iconAsset: "assets/icons/ic_done.svg",
                                    title: data.categoryType ==
                                            "INFRASTRUKTUR_DESA"
                                        ? "Infrastruktur desa"
                                        : data.categoryType ==
                                                "INVENTARIS_PEMERINTAH"
                                            ? "Inventaris Pemerintah Desa"
                                            : data.categoryType ==
                                                    "BANTUAN_SOSIAL"
                                                ? "Bantuan Sosial"
                                                : "",
                                    subTitle: data.title),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 16),
                                      Text(
                                        'Biaya',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.descText),
                                      ),
                                      Text(
                                        formatRupiah(
                                            double.parse(data.cost).toInt()),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.primary),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Selengkapnya',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.primary),
                                      ),
                                      SizedBox(
                                        width: 1,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                        color: AppColor.primary,
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

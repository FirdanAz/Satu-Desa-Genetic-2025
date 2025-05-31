import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satu_desa/core/public/function.dart';
import 'package:satu_desa/core/public/shimmer/shimmer_kabar_desa.dart';
import 'package:satu_desa/core/public/widgets/info_empty_widget.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/kabar_desa/cubit/kabar_desa_cubit.dart';
import 'package:satu_desa/features/kabar_desa/views/widgets/kabar_desa_appbar_widget.dart';
import 'package:satu_desa/features/kabar_desa/views/widgets/kabar_desa_card_widget.dart';
import 'package:satu_desa/features/kabar_desa/views/widgets/kabar_desa_list_card_widget.dart';

class KabarDesaPage extends StatefulWidget {
  const KabarDesaPage({super.key});

  @override
  State<KabarDesaPage> createState() => _KabarDesaPageState();
}

class _KabarDesaPageState extends State<KabarDesaPage> {
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<KabarDesaCubit>().getKabarDesa();
  }

  // void _listener(BuildContext context, KabarDesaState state) {
  //   if (state.status == KabarDesaStatus.loading) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => Dialog.fullscreen(
  //         child: ShimmerKabarDesaPage(),
  //       ),
  //     );
  //   } else if (state.status == KabarDesaStatus.failed) {
  //     showDialog(context: context, builder: (context) => Dialog.fullscreen(
  //       child: InfoEmptyWidget(emptyText: "Kosong!"),
  //     ),);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        automaticallyImplyLeading: false,
        toolbarHeight: 5,
      ),
      backgroundColor: AppColor.bgButton,
      body: BlocBuilder<KabarDesaCubit, KabarDesaState>(
        builder: (context, state) {
          print("Jumlah data yang muncul: ${state.kabarDesaModel?.kabarDesa?.length}");

          if (state.status == KabarDesaStatus.loading) {
            return ShimmerKabarDesaPage();
          } else if (state.status == KabarDesaStatus.success) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 305,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Color(0xFF6DB389), Color(0xFF3F7D58)],
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
                          Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [KabarDesaAppBarWidget(searchController: _searchController,)],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    height: 240,
                    child: ListView.builder(
                        itemCount: state.kabarDesaModel!.kabarDesa!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final kabarDesa = state.kabarDesaModel!.kabarDesa![index];
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: 350,
                            child: KabarDesaUtamaCard(
                                imageUrl:
                                    kabarDesa.picturePath!,
                                title:
                                    kabarDesa.title!,
                                date: PublicFunction().formatTanggal(kabarDesa.createdAt!)),
                          );
                        }),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kabar desa lainnya",
                          style: TextStyle(
                              color: AppColor.titleText,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return KabarDesaListCardWidget(
                                imageUrl:
                                    "https://gudangjogja.id/images/berita/gudang-jogja-fakta-menarik-tugu-yogyakarta-asal-usul-hingga-filosofi-98.jpeg",
                                title:
                                    "Pelantikan Kepala Desa Desa Maju, Masa Jabatan 2025 - 2033",
                                date: "20 Januari 2025");
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return InfoEmptyWidget(emptyText: "Kabar Desa");
          }
        },
      ),
    );
  }
}

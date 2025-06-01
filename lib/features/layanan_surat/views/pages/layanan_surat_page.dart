import 'package:flutter/material.dart';
import 'package:satu_desa/core/public/widgets/app_bar_card_widget.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/layanan_surat/views/widgets/menu_layanan_widget.dart';

class LayananSuratPage extends StatefulWidget {
  const LayananSuratPage({super.key});

  @override
  State<LayananSuratPage> createState() => _LayananSuratPageState();
}

class _LayananSuratPageState extends State<LayananSuratPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        automaticallyImplyLeading: false,
        toolbarHeight: 5,
      ),
      backgroundColor: AppColor.bgButton,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: AppBarCardWidget(
                  backgroundColor: AppColor.primary,
                  title: "Urus Surat Lebih Mudah, Tanpa Ribet!",
                  iconPath: "ic_layanan_surat.png",
                  appBarTitle: "Layanan Surat",
                  desc: "Tak perlu antre. Urus surat kapan saja, di mana saja.",
                )),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(30.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MenuLayananSuratWidget(title: "Domisili", iconAsset: "ic_domisili.svg"),
                      MenuLayananSuratWidget(title: "SKU", iconAsset: "ic_sku.svg"),
                      MenuLayananSuratWidget(title: "SKCK", iconAsset: "ic_skck.svg"),
                      MenuLayananSuratWidget(title: "SKTM", iconAsset: "ic_sktm.svg"),
                    ],
                  ),
                  SizedBox(height: 16.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MenuLayananSuratWidget(title: "Kelahiran", iconAsset: "ic_kelahiran.svg"),
                      MenuLayananSuratWidget(title: "Kematian", iconAsset: "ic_kematian.svg"),
                      MenuLayananSuratWidget(title: "Nikah", iconAsset: "ic_pernikahan.svg"),
                      MenuLayananSuratWidget(title: "Hajatan", iconAsset: "ic_hajatan.svg"),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

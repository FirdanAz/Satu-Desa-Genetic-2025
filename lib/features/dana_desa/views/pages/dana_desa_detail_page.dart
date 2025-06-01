import 'package:flutter/material.dart';
import 'package:satu_desa/core/public/widgets/custom_list_tile.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/dana_desa/models/dana_desa_model.dart'
    as dana;
import 'package:satu_desa/features/dana_desa/views/widgets/dana_desa_detail_card.dart';

class DanaDesaDetailPage extends StatefulWidget {
  const DanaDesaDetailPage({super.key, required this.dataUsage});
  final dana.Usage dataUsage;

  @override
  State<DanaDesaDetailPage> createState() => _DanaDesaDetailPageState();
}

class _DanaDesaDetailPageState extends State<DanaDesaDetailPage> {
  List<String> imageUrls = [];

  @override
  Widget build(BuildContext context) {
    if (widget.dataUsage.images.isNotEmpty) {
      imageUrls.addAll(
        widget.dataUsage.images
            .where((img) => img.imagePath.isNotEmpty)
            .map((img) => img.imagePath),
      );
    }
    print(imageUrls);
    String title = widget.dataUsage.categoryType == "INFRASTRUKTUR_DESA"
        ? "Infrastruktur desa"
        : widget.dataUsage.categoryType == "INVENTARIS_PEMERINTAH"
            ? "Inventaris Pemerintah Desa"
            : widget.dataUsage.categoryType == "BANTUAN_SOSIAL"
                ? "Bantuan Sosial"
                : "";
    String iconPath = widget.dataUsage.categoryType == "INFRASTRUKTUR_DESA"
        ? "ic_infrastruktur"
        : widget.dataUsage.categoryType == "INVENTARIS_PEMERINTAH"
            ? "ic_inventaris"
            : widget.dataUsage.categoryType == "BANTUAN_SOSIAL"
                ? "ic_bantuan_sosial"
                : "";
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail $title'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(20)),
                child: CustomListTile(
                  iconAsset: 'assets/icons/$iconPath.svg',
                  title: title,
                  subTitle: widget.dataUsage.fundCode!,
                  titleColor: Colors.white,
                  subTitleColor: Colors.white,
                  bgIconColor: Colors.white,
                  iconColor: AppColor.primary,
                  iconPadding: 7,
                  // action: "Biaya\nRp.180.000.000",
                  // actionColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Transaksi Penggunaan Anggaran Desa",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColor.titleText),
              ),
              const SizedBox(
                height: 16,
              ),
              DanaDesaDetailCard(
                  dataUsage: widget.dataUsage, urlImages: imageUrls),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:satu_desa/core/public/function.dart';
import 'package:satu_desa/core/public/pages/photo_detail_page.dart';
import 'package:satu_desa/core/public/widgets/list_tile_image_widget.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/dana_desa/models/dana_desa_model.dart';

class DanaDesaDetailCard extends StatelessWidget {
  const DanaDesaDetailCard(
      {super.key, required this.dataUsage, this.urlImages});
  final Usage dataUsage;
  final List<String>? urlImages;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dataUsage.title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            dataUsage.description,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColor.descText),
          ),
          const SizedBox(
            height: 14,
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
                dataUsage.location,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColor.descText),
              ),
            ],
          ),
          const SizedBox(
            height: 9,
          ),
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
                '${PublicFunction().formatTanggal(dataUsage.startDate)} - ${PublicFunction().formatTanggal(dataUsage.endDate)}',
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
            'Biaya',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColor.descText),
          ),
          const SizedBox(height: 4),
          Text(
            PublicFunction().formatRupiah(dataUsage.cost),
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColor.primary),
          ),
          const SizedBox(
            height: 16,
          ),
          dataUsage.reportFile != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'File Pelaporan',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColor.descText),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: AppColor.descText, width: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildFileIcon(dataUsage.reportFile!),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            buildFileTitle(
                                dataUsage.reportFile!, dataUsage.title),
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: AppColor.descText),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                )
              : Container(),
          urlImages!.isNotEmpty
              ? InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoDetailPage(
                            imageUrls: urlImages!, initialIndex: 0, heroTag: 'photo_${1}_1',),
                      )),
                  child: ListTileImageWidget(urlImages: urlImages!))
              : Container()
        ],
      ),
    );
  }

  SvgPicture buildFileIcon(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    Color iconColor;

    if (extension == 'pdf') {
      iconColor = Colors.red;
    } else if (extension == 'doc' || extension == 'docx') {
      iconColor = Colors.blue;
    } else {
      iconColor = Colors.grey;
    }

    return SvgPicture.asset('assets/icons/ic_docs.svg', color: iconColor);
  }

  String buildFileTitle(String filePath, String title) {
    final extension = filePath.split('.').last.toLowerCase();

    if (extension == 'pdf') {
      return 'Laporan - $title.pdf';
    } else if (extension == 'doc' || extension == 'docx') {
      return 'Laporan - $title.docx';
    } else {
      return 'Laporan - $title';
    }
  }
}

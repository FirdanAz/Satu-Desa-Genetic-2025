import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile(
      {super.key,
      required this.iconAsset,
      required this.title,
      required this.subTitle,
      this.date});
  final String iconAsset;
  final String title;
  final String subTitle;
  final String? date;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 40,
          height: 40,
          padding: EdgeInsetsDirectional.all(10),
          decoration: BoxDecoration(
              color: AppColor.primary, borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset(
            widget.iconAsset,
            width: 19,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 14,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColor.titleText),
            ),
            Text(
              widget.subTitle,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.descText),
            ),
          ],
        ),
        Spacer(),
        widget.date != null
            ? Align(
                child: Text(
                  widget.date!,
                  style: TextStyle(fontSize: 11, color: AppColor.descText),
                ),
              )
            : Container()
      ],
    );
  }
}

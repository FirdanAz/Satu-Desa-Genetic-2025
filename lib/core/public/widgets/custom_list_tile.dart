import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile(
      {super.key,
      required this.iconAsset,
      required this.title,
      required this.subTitle,
      this.action,
      this.titleColor,
      this.subTitleColor,
      this.bgIconColor,
      this.iconColor,
      this.iconPadding,
      this.actionColor});
  final String iconAsset;
  final String title;
  final String subTitle;
  final String? action;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? bgIconColor;
  final Color? iconColor;
  final Color? actionColor;
  final double? iconPadding;

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
          padding: EdgeInsetsDirectional.all(widget.iconPadding ?? 10),
          decoration: BoxDecoration(
              color: widget.bgIconColor ?? AppColor.primary,
              borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset(
            widget.iconAsset,
            width: 19,
            fit: BoxFit.cover,
            color: widget.iconColor ?? Colors.white,
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
                  color: widget.titleColor ?? AppColor.titleText),
            ),
            Text(
              widget.subTitle,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: widget.subTitleColor ?? AppColor.descText),
            ),
          ],
        ),
        Spacer(),
        widget.action != null
            ? Text(
              widget.action!,
              style: TextStyle(fontSize: 11, color: widget.actionColor ?? AppColor.descText),
            )
            : Container()
      ],
    );
  }
}

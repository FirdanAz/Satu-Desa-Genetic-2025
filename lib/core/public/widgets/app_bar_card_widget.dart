import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class AppBarCardWidget extends StatelessWidget {
  const AppBarCardWidget(
      {super.key,
      required this.title,
      this.btnText,
      required this.iconPath,
      required this.appBarTitle,
      this.onTap,
      this.desc,
      this.backgroundColor});
  final String appBarTitle;
  final String title;
  final String? btnText;
  final String iconPath;
  final VoidCallback? onTap;
  final String? desc;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      decoration: backgroundColor == null
          ? BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFF6DB389), Color(0xFF3F7D58)],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            )
          : BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
      child: SafeArea(
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            backgroundColor == null
                ? SvgPicture.asset(
                    'assets/images/bg_auth.svg',
                    fit: BoxFit.fitWidth,
                  )
                : Container(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backgroundColor != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 30, bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                            ),
                            const SizedBox(width: 14),
                            const Text(
                              'Layanan Surat',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 30, bottom: 15),
                        child: Text(
                          appBarTitle,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SvgPicture.asset(
                          'assets/images/bg_card.svg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  desc != null
                                      ? Text(
                                          desc!,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColor.descText,
                                              fontWeight: FontWeight.w500),
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: desc != null ? 10 : 35,
                                  ),
                                  btnText != null
                                      ? InkWell(
                                          onTap: onTap,
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 13, vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: AppColor.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                btnText!,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              )),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            Image.asset(
                              'assets/icons/$iconPath',
                              height: 130,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

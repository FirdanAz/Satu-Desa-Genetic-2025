import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/musyawarah/views/pages/musyawarah_detail_page.dart';

class MusyawarahPage extends StatelessWidget {
  const MusyawarahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          toolbarHeight: 5,
        ),
        backgroundColor: AppColor.bgButton,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 280,
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
                      SvgPicture.asset(
                        'assets/images/bg_auth.svg',
                        fit: BoxFit.fitWidth,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, top: 30, bottom: 20),
                            child: Text(
                              "Aspirasi",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          InkWell(
                            onTap: () => {},
                            child: SizedBox(
                              width: double.maxFinite,
                              child: Image.asset(
                                'assets/images/dummy_musyarawah.png',
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MusyawarahDetailPage(),)),
                  child: Image.asset("assets/images/dummy_musyawarah_list.png")),
              ),
            )
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
        ));
  }
}

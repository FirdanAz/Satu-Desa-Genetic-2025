import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:satu_desa/core/public/shimmer/shimmer_bayar_sampah_page.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/aspiration/cubit/aspiration_cubit.dart';
import 'package:satu_desa/features/aspiration/views/pages/create_aspiration.dart';
import 'package:satu_desa/features/aspiration/views/widgets/aspirasi_widget.dart';

class AspirationPage extends StatefulWidget {
  const AspirationPage({super.key});

  @override
  State<AspirationPage> createState() => _AspirationPageState();
}

class _AspirationPageState extends State<AspirationPage> {
  final cubit = AspirationCubit()..getAspirasi();

  @override
  Widget build(BuildContext context) {
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
                                padding: const EdgeInsets.only(left: 30, top: 30, bottom: 20),
                                child: Text("Aspirasi", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight:FontWeight.w500),),
                              ),
                              InkWell(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAspirationPage(),)),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: Image.asset(
                                    'assets/images/dummy_aspirasi.png',
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
                    child: Image.asset(
                      "assets/images/dummy_aspirasi_list.png"
                    ),
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
}

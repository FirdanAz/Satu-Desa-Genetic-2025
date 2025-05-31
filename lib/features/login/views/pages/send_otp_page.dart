import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/core/utils/local_data/local_data_persistance.dart';
import 'package:satu_desa/core/widgets/snackbar.dart';
import 'package:satu_desa/features/bottom_navigation/views/home_nav_wrapper.dart';
import 'package:satu_desa/features/login/cubit/otp/otp_cubit.dart';

// ignore: must_be_immutable
class SendOtpPage extends StatefulWidget {
  SendOtpPage({super.key, required this.bearerToken, required this.email});
  String bearerToken;
  String email;

  @override
  State<SendOtpPage> createState() => _SendOtpPageState();
}

class _SendOtpPageState extends State<SendOtpPage> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _onSubmitOtp(BuildContext context, String otp) {
    if (otp.length == 6) {
      context.read<OtpCubit>().verifyOtp(
          bearerToken: widget.bearerToken, otp: otp, email: widget.email);
    }
  }

  Future<void> _otpListener(BuildContext context, OtpState state) async {
    if (state.status == OtpStatus.failed) {
      showSnackBar(
        context,
        color: Colors.red,
        duration: Duration(seconds: 2),
        content: Text(state.errorMessage ?? 'Kode salah atau kadaluarsa'),
      );
    } else if (state.status == OtpStatus.verifed) {
      showSnackBar(
        context,
        color: Colors.green,
        duration: Duration(seconds: 2),
        content: Text('Kode berhasil diverifikasi'),
      );
      final LocalDataPersistance localDataPersistance = LocalDataPersistance();
      await localDataPersistance.setBearerToken(widget.bearerToken);
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeNavWrapper()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40))),
                )),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.passthrough,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[AppColor.secondary, AppColor.primary],
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/bg_auth.svg',
                    fit: BoxFit.fitWidth,
                  ),
                  Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/logo_white.svg',
                              width: 48.0,
                            ),
                            SizedBox(
                              width: 14.0,
                            ),
                            Text(
                              'SATU DESA',
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 38.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocConsumer<OtpCubit, OtpState>(
              listener: _otpListener,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Masukkan Kode OTP!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Kami telah mengirimkan kode 6 digit ke Email Anda.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 32),
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        controller: _otpController,
                        onChanged: (value) {},
                        onCompleted: (value) => _onSubmitOtp(context, value),
                        autoDismissKeyboard: true,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          activeColor: AppColor.primary,
                          selectedColor: AppColor.primary,
                          inactiveColor: Colors.grey.shade300,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Belum menerima kodenya?',
                            style: TextStyle(color: Colors.black54),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'Kirim ulang kode',
                              style: TextStyle(color: AppColor.primary),
                            ),
                          ),
                        ],
                      ),
                      if (state.status == OtpStatus.loading)
                        const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

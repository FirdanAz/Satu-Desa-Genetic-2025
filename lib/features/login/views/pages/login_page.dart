import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:satu_desa/core/public/function.dart';
import 'package:satu_desa/core/public/widgets/input_field_widget.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/core/widgets/snackbar.dart';
import 'package:satu_desa/features/login/cubit/login_cubit.dart';
import 'package:satu_desa/features/login/cubit/otp/otp_cubit.dart';
import 'package:satu_desa/features/login/views/pages/send_otp_page.dart';
import 'package:satu_desa/features/login/views/widgets/custom_button_widget.dart';
import 'package:satu_desa/features/register/views/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailEditController = TextEditingController();
  final TextEditingController _passwordEditController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailEditController.dispose();
    _passwordEditController.dispose();
  }

  void _performLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<LoginCubit>(context).postLogin(
          email: _emailEditController.text,
          password: _passwordEditController.text);
    }
  }

  void _loginListener(BuildContext context, LoginState state) {
    if (state.status == LoginStateStatus.failed) {
      showSnackBar(
        context,
        duration: const Duration(seconds: 2),
        color: Colors.white,
        content: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Container(
            color: AppColor.bgButtonBorder,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.close, color: Colors.red, size: 18),
                const SizedBox(width: 15),
                Text(
                  state.errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (state.status == LoginStateStatus.success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (_) => OtpCubit()
                    ..sendOtp(
                        bearerToken: state.loginModel!.data.token,
                        email: state.loginModel!.data.user.email),
                  child: SendOtpPage(
                    bearerToken: state.loginModel!.data.token,
                    email: state.loginModel!.data.user.email,
                  ),
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    PublicFunction()
        .setSystemUiOverlay(Colors.white, Colors.white, Brightness.dark);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 70),
        child: InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterPage(),
              ),
              (route) => false,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Belum punya akun? ',
                style: TextStyle(color: AppColor.descText, letterSpacing: 0.0),
              ),
              Text(
                'Daftar',
                style: TextStyle(
                    color: AppColor.primary, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 290,
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
                        Text(
                          'Hai, Selamat Datang\nMasukkan Akunmu Terlebih Dahulu',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              height: 1.4),
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          BlocConsumer<LoginCubit, LoginState>(
            listener: _loginListener,
            builder: (context, state) {
              return SliverToBoxAdapter(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        InputFieldWidget(
                          textEditingController: _emailEditController,
                          hintText: 'Email',
                          iconPath: 'assets/icons/ic_email.svg',
                          isPassword: false,
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        InputFieldWidget(
                          textEditingController: _passwordEditController,
                          hintText: 'Password',
                          iconPath: 'assets/icons/ic_lock.svg',
                          isPassword: true,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          height: 40.0,
                          child: state.status == LoginStateStatus.loading
                              ? CustomButtonWidget(
                                  bgColor: AppColor.bgButtonBorder,
                                  titleColor: AppColor.descText,
                                  title: "",
                                  isLoad: true,
                                )
                              : CustomButtonWidget(
                                  bgColor: AppColor.primary,
                                  titleColor: Colors.white,
                                  title: "Masuk",
                                  isLoad: false,
                                  onPress:
                                      (state.status == LoginStateStatus.loading)
                                          ? null
                                          : () => _performLogin(context),
                                ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade400,
                                thickness: 1,
                                endIndent: 12,
                              ),
                            ),
                            Text(
                              'Atau masuk dengan',
                              style: TextStyle(
                                color: AppColor.descText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade400,
                                thickness: 1,
                                indent: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          height: 40.0,
                          child: CustomButtonWidget(
                            bgColor: Colors.white,
                            titleColor: AppColor.descText,
                            title: "Masuk dengan Google",
                            isLoad: false,
                            svgAsset: 'assets/images/logo_google.svg',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:satu_desa/core/public/function.dart';
import 'package:satu_desa/core/public/widgets/input_field_widget.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/login/views/pages/login_page.dart';
import 'package:satu_desa/features/login/views/widgets/custom_button_widget.dart';
import 'package:satu_desa/features/register/cubit/register_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _userNameEditController = TextEditingController();
  final TextEditingController _emailEditController = TextEditingController();
  final TextEditingController _passwordEditController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _userNameEditController.dispose();
    _emailEditController.dispose();
    _passwordEditController.dispose();
  }

  void _performLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<RegisterCubit>(context).postRegister(
          userName: _userNameEditController.text,
          email: _emailEditController.text,
          password: _passwordEditController.text);
    }
  }

  void _loginListener(BuildContext context, RegisterState state) {
    if (state.status == RegisterStateStatus.failed) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Daftar Gagal',
        desc: 'Periksa kembali email dan password anda',
        btnOkOnPress: () {
          
        },
        btnOkText: "Coba Lagi",
        btnOkColor: AppColor.primary
      ).show();
    } else if (state.status == RegisterStateStatus.success) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Daftar Sukses',
        desc: 'Daftar sukses!, silahkan lanjutkan kehalaman Login',
        btnOkOnPress: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
            (route) => false,
          );
        },
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    PublicFunction()
        .setSystemUiOverlay(Colors.white, Colors.white, Brightness.dark);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(bottom: 70),
        child: InkWell(
          child: InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
                (route) => false,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sudah punya akun? ',
                  style:
                      TextStyle(color: AppColor.descText, letterSpacing: 0.0),
                ),
                Text(
                  'Masuk',
                  style: TextStyle(
                      color: AppColor.primary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
          BlocConsumer<RegisterCubit, RegisterState>(
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
                          textEditingController: _userNameEditController,
                          hintText: 'Nama Lengkap',
                          iconPath: 'assets/icons/ic_nama_lengkap.svg',
                          isPassword: false,
                        ),
                        SizedBox(
                          height: 14,
                        ),
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
                          child: state.status == RegisterStateStatus.loading
                              ? CustomButtonWidget(
                                  bgColor: AppColor.bgButtonBorder,
                                  titleColor: AppColor.descText,
                                  title: "",
                                  isLoad: true,
                                )
                              : CustomButtonWidget(
                                  bgColor: AppColor.primary,
                                  titleColor: Colors.white,
                                  title: "Daftar",
                                  isLoad: false,
                                  onPress: (state.status ==
                                          RegisterStateStatus.loading)
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
                              'Atau daftar dengan',
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
                            title: "Daftar dengan Google",
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

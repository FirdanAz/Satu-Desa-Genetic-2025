import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/profile/views/widgets/password_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ganti Password'),
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
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            PasswordField(
              controller: passwordController,
              title: "Password Lama",
            ),
            SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Lupa Password?",
                style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            PasswordField(
              controller: passwordController,
              title: "Password Baru",
            ),
            SizedBox(
              height: 20,
            ),
            PasswordField(
              controller: passwordController,
              title: "Konfirmasi Password Baru",
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColor.primary,
                    disabledForegroundColor: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: AppColor.descText),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Simpan Perubahan",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 66,
            )
          ],
        ),
      ),
    );
  }
}

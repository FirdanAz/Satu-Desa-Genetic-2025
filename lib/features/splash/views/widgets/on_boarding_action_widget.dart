import 'package:flutter/material.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/login/views/pages/login_page.dart';
import 'package:satu_desa/features/register/views/pages/register_page.dart';

class OnBoardingActionWidget extends StatelessWidget {
  const OnBoardingActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColor.primary,
                disabledForegroundColor: Colors.red,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                  (route) => false,
                );
              },
              child: Text('Masuk'),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primary,
                backgroundColor: AppColor.bgButton,
                disabledForegroundColor: Colors.red,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: AppColor.bgButtonBorder),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                  (route) => false,
                );
              },
              child: Text('Daftar'),
            ),
          )
        ],
      ),
    );
  }
}

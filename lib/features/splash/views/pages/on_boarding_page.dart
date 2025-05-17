import 'package:flutter/material.dart';
import 'package:satu_desa/core/public/function.dart';
import 'package:satu_desa/core/theme/app_color.dart';
import 'package:satu_desa/features/splash/views/widgets/on_boarding_action_widget.dart';
import 'package:satu_desa/features/splash/views/widgets/on_boarding_widget.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicFunction()
        .setSystemUiOverlay(Colors.white, Colors.white, Brightness.dark);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Container(
        color: Colors.white,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 70, horizontal: 30),
        child: OnBoardingActionWidget(),
      ),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Lewati",
                      style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ))),
            OnBoardingWidget(),
            Container(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}

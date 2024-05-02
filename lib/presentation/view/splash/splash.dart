// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'dart:async';
import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/view/splash/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Timer(
        const Duration(
          seconds: 3,
        ), () {
      Get.offAll(
        () => const WelcomeFirstScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            color: AppTheme.isLightTheme == false
                ? HexColor('#15141F')
                : HexColor(AppTheme.primaryColorString!)),
        child: Column(
          children: [
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 150,
                  child: Image.asset(DefaultImages.finalLogo,
                      color: HexColor(AppTheme.secondaryColorString!)),
                ),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.pay_to_me,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: const Color(0xffDCDBE0),
                      ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 48, bottom: 20),
              child: Text(
                AppLocalizations.of(context)!.app_description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: const Color(0xffDCDBE0),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

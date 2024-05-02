// ignore_for_file: deprecated_member_use

import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/fingerprint_controller..dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FingerPrintScreen extends StatefulWidget {
  const FingerPrintScreen({Key? key}) : super(key: key);

  @override
  State<FingerPrintScreen> createState() => _FingerPrintScreenState();
}

class _FingerPrintScreenState extends State<FingerPrintScreen> {
  final fingerPrintController = Get.put(FingerPrintController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppTheme.isLightTheme == false
            ? const Color(0xff15141F)
            : const Color(0xffFFFFFF),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 55),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            AppTheme.isLightTheme == false
                                ? DefaultImages.darkFinger
                                : DefaultImages.fingerBg,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: AppBar().preferredSize.height,
                            ),
                            child: InkWell(
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(Icons.arrow_back)),
                          ),
                          SizedBox(
                            height: Get.height / 5,
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.fingerprint,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 24,
                                      ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 45.0, right: 45),
                                  child: Text(
                                    AppLocalizations.of(context)!.fingerprint_desc,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: const Color(0xffA2A0A8)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      fingerPrintController.verifyFingerprint(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          AppTheme.isLightTheme == false
                              ? DefaultImages.darkScanner
                              : DefaultImages.fingerPrint,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

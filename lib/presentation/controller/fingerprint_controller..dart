// ignore_for_file: deprecated_member_use

import 'package:finpay/config/injection.dart';
import 'package:finpay/config/services/local/local_biometric.dart';
import 'package:finpay/presentation/view/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/default_snackbar.dart';

class FingerPrintController extends GetxController {
  verifyFingerprint(BuildContext context) async {
    final response = await locators.get<BiometricService>().verifyFingerPrint();
    response.fold(
      (l) {
        if (!l.errMessage.contains('cancelled')) {
          DefaultSnackbar.snackBar(
            context: context,
            message: l.errMessage,
            snackPosition: SnackPosition.TOP,
          );
        }
      },
      (r) {
        Get.offAll(
          () => const TabScreen(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(
            milliseconds: 500,
          ),
        );
      },
    );
  }
}

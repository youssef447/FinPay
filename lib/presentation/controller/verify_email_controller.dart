import 'package:finpay/config/injection.dart';
import 'package:finpay/core/utils/default_dialog.dart';
import 'package:finpay/data/repositories/auth_repo.dart';
import 'package:finpay/presentation/view/signup/pin_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/default_snackbar.dart';

class VerifyEmailController extends GetxController {
  RxBool loadingVerify = false.obs;
  RxBool loadingResend = false.obs;

  verifyEmailCode({
    required String code,
    required String userId,
    required String email,
    required String pass,
    required BuildContext context,
  }) async {
    loadingVerify.value = true;
    final response = await locators.get<UserAuthRepo>().verifyEmailCode(
          code: code,
          id: userId,
        );
    try {
      await locators.get<UserAuthRepo>().login(
            email: email,
            password: pass,
          );
      loadingVerify.value = false;
    } catch (e) {
      loadingVerify.value = false;

      if (context.mounted) {
        DefaultSnackbar.snackBar(
            context: context, message: e.toString(), title: 'failed');
      }
    }

    response.fold((l) {
      DefaultSnackbar.snackBar(
          context: context, message: l.errMessage, title: 'failed');
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: 'email has been verified',
        title: 'Done',
        btnOkOnPress: () {
          Get.offAll(
            const CreatePinScreen(),
          );
        },
      );
    });
  }

  resendCode({required String email, required BuildContext context}) async {
    loadingResend.value = true;

    final response = await locators.get<UserAuthRepo>().sendVerificationEmail(
          email: email,
        );
    loadingResend.value = false;

    response.fold((l) {
      DefaultSnackbar.snackBar(
          context: context, message: l.errMessage, title: 'failed');
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: 'code has been sent successfully',
        title: 'Done',
      );
    });
  }
}

import 'package:finpay/config/injection.dart';
import 'package:finpay/core/utils/default_dialog.dart';
import 'package:finpay/data/repositories/auth_repo.dart';
import 'package:finpay/presentation/view/signup/pin_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    response.fold((l) {
      DefaultSnackbar.snackBar(
          context: context, message: l.errMessage, title: 'failed');
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: AppLocalizations.of(context)!.email_verified,
        title: 'Done',
        btnOkOnPress: () {
          login(context, email: email, pass: pass);
        },
      );
    });
  }

  login(BuildContext ctx, {required String email, required String pass}) async {
    final response = await locators.get<UserAuthRepo>().login(
          email: email,
          password: pass,
        );

    response.fold((l) {
      if (ctx.mounted) {
        DefaultSnackbar.snackBar(
            context: ctx, message: l.errMessage, title: 'failed');
      }
    }, (r) {
      Get.offAll(
        const CreatePinScreen(),
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
        body: AppLocalizations.of(context)!.code_sent_successfully,
        title: 'Done',
      );
    });
  }
}

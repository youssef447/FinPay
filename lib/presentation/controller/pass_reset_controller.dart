import 'package:finpay/config/injection.dart';
import 'package:finpay/core/utils/default_dialog.dart';
import 'package:finpay/data/repositories/user_repo.dart';
import 'package:finpay/presentation/view/login/login_screen.dart';
import 'package:finpay/presentation/view/login/reset_pswd_screen.dart';
import 'package:finpay/presentation/view/signup/pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repositories/auth_repo.dart';
import '../../core/utils/default_snackbar.dart';
import '../view/login/verify_reset_pswd_screen.dart';

class PasswordResetController extends GetxController {
  //pswd recovery

  RxBool isNewVisible = false.obs;
  RxBool isConfirmVisible = false.obs;
  RxBool requiredPinMsg = false.obs;
  RxBool loadingSend = false.obs;
  RxBool loadingResend = false.obs;

  RxBool loadingVerify = false.obs;
  RxBool loadingReset = false.obs;

  sendPasswordResetEmail({
    required String email,
  }) async {
    loadingSend.value = true;

    final response = await locators.get<UserAuthRepo>().sendPasswordResetEmail(
          email: email,
        );
    loadingSend.value = false;

    response.fold((l) {
      //show failed Message
      Get.showSnackbar(GetSnackBar(
        title: 'failed to send email',
        message: '${l.errMessage}, please try again',
        backgroundColor: Colors.redAccent,
        duration: const Duration(
          seconds: 5,
        ),
      ));
    }, (r) {
      Get.to(
        () => VerifyResetPswdScreen(
          email: email,
        ),
        transition: Transition.rightToLeft,
        duration: const Duration(
          milliseconds: 500,
        ),
      );
    });
  }

  resendCode({required String email, required BuildContext context}) async {
    loadingResend.value = true;

    final response = await locators.get<UserAuthRepo>().sendPasswordResetEmail(
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
          title: 'Done');
    });
  }

  verifyResetCode({
    required String email,
    required String code,
    bool? resetPin,
    bool? transfere,
  }) async {
    loadingVerify.value = true;
    final response = await locators.get<UserAuthRepo>().verifyResetPass(
          email: email,
          code: code,
        );
    loadingVerify.value = false;

    response.fold((l) {
      //show failed Message
      Get.showSnackbar(GetSnackBar(
        message: '${l.errMessage}, please try again',
        backgroundColor: Colors.redAccent,
        duration: const Duration(
          seconds: 5,
        ),
      ));
    }, (r) {
      Get.to(
        () => resetPin ?? false
            ? CreatePinScreen()
            : transfere ?? false
                ? CreatePinScreen(
                    transfere: transfere,
                  )

                ///normal forgot pswd screen
                : ResetPasswordScreen(
                    email: email,
                    code: code,
                  ),
        transition: Transition.rightToLeft,
        duration: const Duration(
          milliseconds: 500,
        ),
      );
    });
  }

  resetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    loadingReset.value = true;
    final response = await locators.get<UserAuthRepo>().resetPass(
          email: email,
          password: password,
          code: code,
        );
    loadingReset.value = false;

    response.fold((l) {
      //show failed Message
      Get.showSnackbar(GetSnackBar(
        title: 'failed to reset password',
        message: l.errMessage,
        backgroundColor: Colors.redAccent,
        duration: const Duration(
          seconds: 5,
        ),
      ));
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: Get.context!,
        body: 'password reset successfully!',
        title: 'Done',
        btnOkOnPress: () => Get.to(
          () => const LoginScreen(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  updatePassword({
    required String pass,
  }) async {
    loadingReset.value = true;
    final response = await locators
        .get<UserRepo>()
        .updatePassword(psswd1: pass, psswd2: pass);
    loadingReset.value = false;

    response.fold((l) {
      //show failed Message
      Get.showSnackbar(GetSnackBar(
        title: 'failed',
        message: l.errMessage,
        backgroundColor: Colors.redAccent,
        duration: const Duration(
          seconds: 5,
        ),
      ));
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: Get.context!,
        body: 'password updated successfully!',
        title: 'Done',
        btnOkOnPress: () {
          Get.back();
        },
      );
    });
  }
}

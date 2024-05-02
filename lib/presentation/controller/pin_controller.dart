// ignore_for_file: deprecated_member_use

import 'package:finpay/config/injection.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/data/repositories/auth_repo.dart';
import 'package:finpay/presentation/view/login/verify_reset_pswd_screen.dart';
import 'package:finpay/presentation/view/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/default_snackbar.dart';
import '../view/login/login_screen.dart';

class PinController extends GetxController {
  RxBool loading = false.obs;
  RxBool loadingReset = false.obs;
  RxBool loadingLogout = false.obs;

  /// logup or first login
  createPin({
    required String userId,
    required String pin,
    required BuildContext context,
  }) async {
    loading.value = true;

    final response =
        await locators.get<UserAuthRepo>().createPin(id: userId, pin: pin);
    loading.value = false;

    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        title: 'failed',
      );
    }, (r) async {
      Get.offAll(
        const TabScreen(),
        transition: Transition.rightToLeft,
        duration: const Duration(
          milliseconds: 500,
        ),
      );
    });
  }

  createPinTransfere({
    required String userId,
    required String pin,
    required BuildContext context,
  }) async {
    loading.value = true;

    final response =
        await locators.get<UserAuthRepo>().createPin(id: userId, pin: pin);
    loading.value = false;

    response.fold((l) {
      Get.offAll(const TabScreen());
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        title: 'failed',
      );
    }, (r) {
      Get.offAll(const TabScreen());
    });
  }

  ///login
  verifyPin({required String pin, required BuildContext context}) async {
    loading.value = true;
    final response = await locators.get<UserAuthRepo>().verifyPin(
          pin: pin,
        );
    loading.value = false;

    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        title: 'failed',
      );
    }, (r) {
      Get.offAll(
        () => const TabScreen(),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(
          milliseconds: 500,
        ),
      );
    });
  }

  ///Sends email verification code
  resetPin({required BuildContext context, bool? transfere}) async {
    loadingReset.value = true;
    final response = await locators.get<UserAuthRepo>().sendPasswordResetEmail(
          email: currentUser.email,
        );
    loadingReset.value = false;

    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        title: 'failed',
      );
    }, (r) {
      Get.to(
        () => transfere ?? false
            ? VerifyResetPswdScreen(
                email: currentUser.email,
                transfere: true,//transfere
              )
            : VerifyResetPswdScreen(
                email: currentUser.email,
                resetPin: true,
              ),
        transition: Transition.downToUp,
      );
    });
  }

  verifyPinTransfere(
      {required String pin, required BuildContext context}) async {
    loading.value = true;
    final response = await locators.get<UserAuthRepo>().verifyPin(
          pin: pin,
        );
    loading.value = false;

    response.fold((l) {
      Get.back(result: false);
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        title: 'failed',
      );
    }, (r) {
      Get.back(result: true);
    });
  }

  logout({required BuildContext context}) async {
    loadingLogout.value = true;
    final response = await locators.get<UserAuthRepo>().logout();
    loadingLogout.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        title: 'failed',
      );
    }, (r) {
      Get.offAll(
        () => const LoginScreen(),
        transition: Transition.leftToRightWithFade,
        duration: const Duration(
          milliseconds: 500,
        ),
      );
    });
  }
}

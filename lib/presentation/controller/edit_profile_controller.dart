// ignore_for_file: deprecated_member_use


import 'package:finpay/config/injection.dart';
import 'package:finpay/core/utils/default_dialog.dart';
import 'package:finpay/data/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/default_snackbar.dart';

class EditProfileController extends GetxController {
  RxBool loading = false.obs;

  updateProfile({
    required BuildContext context,
    required String fullName,
  }) async {
    loading.value = true;

    final response =
        await locators.get<UserRepo>().updateProfile(fullName: fullName);
    loading.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          snackPosition: SnackPosition.TOP,
        );
      },
      (r) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: r,
          title: 'Done',
          btnOkOnPress: () {
            Get.back();
          },
        );
      },
    );
  }

  updatePhone({
    required BuildContext context,
    required String phone,
  }) async {
    loading.value = true;

    final response = await locators.get<UserRepo>().updatePhone(phone: phone);
    loading.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          snackPosition: SnackPosition.TOP,
        );
      },
      (r) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: r,
          title: 'Done',
          btnOkOnPress: () {
            Get.back();
          },
        );
      },
    );
  }

  updatePass({
    required BuildContext context,
    required String pass1,
    required String pass2,
  }) async {
    loading.value = true;

    final response = await locators
        .get<UserRepo>()
        .updatePassword(psswd1: pass1, psswd2: pass2);
    loading.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          snackPosition: SnackPosition.TOP,
        );
      },
      (r) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: r,
          title: 'Done',
          btnOkOnPress: () {
            Get.back();
          },
        );
      },
    );
  }

  updateEmail({
    required BuildContext context,
    required String email,
  }) async {
    loading.value = true;

    final response = await locators.get<UserRepo>().updateEmail(email: email);
    loading.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          snackPosition: SnackPosition.TOP,
        );
      },
      (r) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: r,
          title: 'Done',
          btnOkOnPress: () {
            //Get.back();
          },
        );
      },
    );
  }
}

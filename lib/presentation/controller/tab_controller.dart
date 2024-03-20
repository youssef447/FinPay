import 'package:finpay/config/services/local/cach_helper.dart';
import 'package:finpay/core/utils/default_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/login/login_screen.dart';

class TabScreenController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxInt i = 0.obs;
  customInit() {
    pageIndex.value = 0;
  }

  skipBoarding(BuildContext context) async {
    try {
      await CacheHelper.saveData(key: 'skipped', value: true);
      Get.offAll(
        const LoginScreen(),
      );
    } catch (e) {
      if (context.mounted) {
        DefaultSnackbar.snackBar(
          context: context,
          message: e.toString(),
          title: 'failed store local data',
        );
      }
    }
  }
}

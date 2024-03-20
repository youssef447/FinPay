// ignore_for_file: deprecated_member_use

import 'package:finpay/config/injection.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/default_snackbar.dart';
import '../../data/models/wallet_model.dart';
import '../../data/repositories/user_repo.dart';

class CardController extends GetxController {
  RxBool loadingWallets = false.obs;
  RxList<WalletModel> allWalletsList = <WalletModel>[].obs;

  getAllWallets({required BuildContext context}) async {
    loadingWallets.value = true;

    final response = await locators.get<UserRepo>().getmyWallets();
    loadingWallets.value = false;

    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        title: 'failed',
      );
    }, (r) {
      allWalletsList.value = r;
    });
  }

  toggleWallet({
    required BuildContext context,
    required bool val,
    required int currentIndex,
  }) async {
    final response = await locators.get<UserRepo>().toggleWallet(
          walletId: allWalletsList[currentIndex].id.toString(),
        );
    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) {
        allWalletsList[currentIndex].hidden.value = !val;
        Get.find<HomeController>().walletIndex.value = 0;
        Get.find<HomeController>().walletsList.value = allWalletsList
            .where((element) => element.hidden.value == false)
            .toList();
      },
    );
  }
}

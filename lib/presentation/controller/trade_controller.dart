// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:finpay/config/injection.dart';
import 'package:finpay/core/utils/default_dialog.dart';
import 'package:finpay/data/models/trader_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/default_snackbar.dart';
import '../../data/models/wallet_model.dart';
import '../../data/repositories/trade_repo.dart';

class TradeController extends GetxController {
  late Rxn<TraderModel> traderModel = Rxn<TraderModel>();
  Rx<File?> file = Rxn<File?>();
  late RxList<TraderServicesModel> traderServicesModel =
      <TraderServicesModel>[].obs;
  late RxList<TraderServicesModel> sortedTraderServices =
      <TraderServicesModel>[].obs;
  RxBool loading = false.obs;

  RxString error = ''.obs;

  getTrades(BuildContext context) async {
    loading.value = true;
    error.value = '';

    final response = await locators.get<TraderRepo>().getTrades();
    loading.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          snackPosition: SnackPosition.TOP,
        );
        error.value = l.errMessage;
      },
      (r) {
        if (r[0] != false) {
          traderModel.value = r[0];
        }
        traderServicesModel.value = r[1];
        sortedTraderServices.value = r[1];
      },
    );
  }

  RxBool loadingJoin = false.obs;

  joinAsTrader(
      {required String traderName, required BuildContext context}) async {
    loadingJoin.value = true;
    final response = await locators
        .get<TraderRepo>()
        .joinAsTrader(traderName: traderName, traderImgFile: file.value);
    loadingJoin.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'Done',
        btnOkOnPress: () {
          Get.back();
        },
      );
    });
  }

  pickIamge({required ImageSource source, required BuildContext ctx}) async {
    final ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(
      imageQuality: 85,
      source: source,
    );
    if (image != null) {
      file.value = File(image.path);
    }
  }

  late  List<WalletModel> walletsList ;

  late RxInt pickedWalletId ;
  RxInt pickedSortedWalletId = 0.obs;
  late RxInt pickedToWalletId ;

  sortTrades(int walletId) {
    pickedSortedWalletId.value = walletId;
    sortedTraderServices.value = traderServicesModel.where((e) {
      return e.toWalletId == walletId || e.fromWalletId == walletId;
    }).toList();
  }

  pickWallet(int id) {
    pickedWalletId.value = id;
  }

  pickToWallet(int id) {
    pickedToWalletId.value = id;
  }

  RxBool loadingAdd = false.obs;

  addTradeService(
      {required String exchangeRate, required BuildContext context}) async {
    loadingAdd.value = true;
    final response = await locators.get<TraderRepo>().addTradeService(
          fromWallet: pickedWalletId.value.toString(),
          toWallet: pickedToWalletId.value.toString(),
          exchangeRate: exchangeRate,
        );
    loadingAdd.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'Done',
        btnOkOnPress: () {
          Get.back();
          getTrades(context);
        },
      );
    });
  }

  RxBool loadingActivation = false.obs;

  deactivateAll({required BuildContext context}) async {
    loadingActivation.value = true;
    final response = await locators.get<TraderRepo>().deactivateAll();
    loadingActivation.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'Done',
        btnOkOnPress: () {
          getTrades(context);
        },
      );
    });
  }

  activateAll({required BuildContext context}) async {
    loadingActivation.value = true;
    final response = await locators.get<TraderRepo>().activateAll();
    loadingActivation.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'Done',
        btnOkOnPress: () {
          getTrades(context);
        },
      );
    });
  }

  RxBool loadingExchange = false.obs;

  exchangeTradement(
      {required String exchangeRate,
      required String tradeId,
      required BuildContext context}) async {
    loadingExchange.value = true;
    final response = await locators
        .get<TraderRepo>()
        .exchangeTradement(exchangeRate: exchangeRate, tradeId: tradeId);
    loadingExchange.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'Done',
        duration: const Duration(seconds: 2),
      );
      Future.delayed(const Duration(seconds: 2)).then((value) => Get.back());
    });
  }

  RxBool editLoading = false.obs;

  editTradeService(
      {required String exchangeRate,
      required String tradeId,
      required BuildContext context}) async {
    loading.value = true;
    final response = await locators
        .get<TraderRepo>()
        .editTradeService(exchangeRate: exchangeRate, tradeId: tradeId);
    loading.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'Done',
        btnOkOnPress: () {
          Get.back();

          getTrades(context);
        },
      );
    });
  }

  activateTradeService(
      {required BuildContext context, required String tradeId}) async {
    editLoading.value = true;
    final response =
        await locators.get<TraderRepo>().activateTradeService(tradeId: tradeId);
    editLoading.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'Done',
        btnOkOnPress: () {
          getTrades(context);
        },
      );
    });
  }

  deactivateTradeService(
      {required BuildContext context, required String tradeId}) async {
    editLoading.value = true;
    final response = await locators
        .get<TraderRepo>()
        .deactivateTradeService(tradeId: tradeId);
    editLoading.value = false;
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
            getTrades(context);
          },
        );
      },
    );
  }

  deleteTradeService(
      {required BuildContext context, required String tradeId}) async {
    editLoading.value = true;
    final response =
        await locators.get<TraderRepo>().deleteTradeService(tradeId: tradeId);
    editLoading.value = false;
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
            getTrades(context);
          },
        );
      },
    );
  }
}

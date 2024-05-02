import 'dart:convert';

import 'package:finpay/config/extensions.dart';
import 'package:finpay/config/injection.dart';
import 'package:finpay/config/services/local/cach_helper.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/data/models/ticket_details_model.dart';
import 'package:finpay/data/repositories/auth_repo.dart';
import 'package:finpay/data/repositories/user_repo.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/presentation/view/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/utils/default_dialog.dart';
import '../../core/utils/default_snackbar.dart';
import '../../data/models/transaction_model.dart';
import '../../main.dart';

class ProfileController extends GetxController {
  RxBool darkMode = false.obs;
  RxBool testMode = currentUser.testMode == 1 ? true.obs : false.obs;
  RxBool pinMode = currentUser.pinCodeRequired == 1 ? true.obs : false.obs;
  RxBool notificationMode =
      currentUser.notificationOn == 1 ? true.obs : false.obs;
  RxBool loadingLogout = false.obs;
  RxBool loadingTickets = false.obs;
  RxBool loadingAllTxn = false.obs;
  RxBool loadingAllTxnErr = false.obs;

  List<TicketModel> tickets = [];
  RxBool loadingTicketsDetails = false.obs;

  RxBool alert = true.obs;
  RxBool expense = true.obs;
  RxBool utilize = false.obs;
  RxBool balance = true.obs;
  RxBool paid = false.obs;
  RxBool spending = true.obs;
  RxInt selectedLang = language == 'ar' ? 1.obs : 0.obs;
  switchTheme({required bool val, required BuildContext context}) async {
    try {
      await CacheHelper.saveData(
        key: 'light',
        value: !val,
      );
      darkMode.value = val;
      if (val == false) {
        MyApp.setCustomeTheme(context, 6);
      } else {
        MyApp.setCustomeTheme(context, 7);
      }
    } catch (e) {
      DefaultSnackbar.snackBar(
        context: Get.context!,
        message: AppLocalizations.of(context)!.err,
        title: 'failed',
      );
    }
  }

  changeLang(int val) async {
    try {
      if (val == 0) {
        await CacheHelper.saveData(key: 'lang', value: 'en');
        await Get.updateLocale(const Locale('en'));
        language = 'en';
      } else if (val == 1) {
        await CacheHelper.saveData(key: 'lang', value: 'ar');
        await Get.updateLocale(const Locale('ar'));
        language = 'ar';
      }
      selectedLang.value = val;
    } catch (e) {
      DefaultSnackbar.snackBar(
        context: Get.context!,
        message: AppLocalizations.of(Get.context!)!.err,
        title: 'failed',
      );
    }
  }

  switchTestMode({required bool val, required BuildContext context}) async {
    final response = await locators.get<UserRepo>().toggleTestMode(val: val);
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        title: 'failed',
      );
    }, (r) async {
      testMode.value = r;
      currentUser.testMode = r ? 1 : 0;
      try {
        await CacheHelper.saveSecureData(
          key: 'user',
          value: json.encode(currentUser.toJson()),
        );
        if (context.mounted) {
          Get.find<HomeController>().customInit(context);
        }
      } catch (e) {
        if (context.mounted) {
          DefaultSnackbar.snackBar(
            context: context,
            message: e.toString(),
            title: 'failed',
          );
        }
      }
    });
  }

  switchNotificationsMode(
      {required bool val, required BuildContext context}) async {
    final response =
        await locators.get<UserRepo>().toggleNotificationsMode(val: val);
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        title: 'failed',
      );
    }, (r) async {
      notificationMode.value = r;
      currentUser.notificationOn = r ? 1 : 0;
      try {
        await CacheHelper.saveSecureData(
          key: 'user',
          value: json.encode(currentUser.toJson()),
        );
      } catch (e) {
        if (context.mounted) {
          DefaultSnackbar.snackBar(
            context: context,
            message: e.toString(),
            title: 'failed',
          );
        }
      }
    });
  }

  switchPinMode({required bool val, required BuildContext context}) async {
    final response = await locators.get<UserRepo>().togglePinMode(val: val);
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        title: 'failed',
      );
    }, (r) async {
      pinMode.value = r;
      currentUser.pinCodeRequired = r ? 1 : 0;
      try {
        await CacheHelper.saveSecureData(
          key: 'user',
          value: json.encode(
            currentUser.toJson(),
          ),
        );
      } catch (e) {
        if (context.mounted) {
          DefaultSnackbar.snackBar(
            context: context,
            message: e.toString(),
            title: 'failed',
          );
        }
      }
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

  String err = '';
  getTickets({required BuildContext context}) async {
    loadingTickets.value = true;
    tickets = [];
    err = '';

    final response = await locators.get<UserRepo>().getTickets();

    response.fold((l) {
      loadingTickets.value = false;

      err = l.errMessage;
    }, (r) async {
      Future.wait(r.map((e) => getTicketsDetails(
            context: context,
            ticketId: e.id.toString(),
          ))).then((value) {
        tickets.sort(
          (a, b) => a.id.compareTo(b.id),
        );
        loadingTickets.value = false;
      });
    });
  }

  getTicketsDetails(
      {required String ticketId, required BuildContext context}) async {
    loadingTicketsDetails.value = true;

    final response =
        await locators.get<UserRepo>().getTicketsDetails(ticketId: ticketId);
    loadingTicketsDetails.value = false;

    response.fold(
      (l) {
        err = l.errMessage;
      },
      (r) {
        tickets.add(r);
      },
    );
  }

  Rxn<TicketModel> details = Rxn<TicketModel>();
  getOneTicketDetails(
      {required String ticketId, required BuildContext context}) async {
    loadingTicketsDetails.value = true;

    final response =
        await locators.get<UserRepo>().getTicketsDetails(ticketId: ticketId);
    loadingTicketsDetails.value = false;

    response.fold(
      (l) {
        err = l.errMessage;
      },
      (r) {
        details.value = r;
      },
    );
  }

  RxBool loadingCreateTicket = false.obs;

  createTicket({
    required String msg,
    String? ticketId,
    bool? oneDetail,
    required BuildContext context,
  }) async {
    loadingCreateTicket.value = true;

    final response = await locators.get<UserRepo>().createTicket(
          ticketId: ticketId,
          msg: msg,
        );
    loadingCreateTicket.value = false;

    response.fold(
      (l) {
        AwesomeDialogUtil.error(
          context: context,
          body: l.errMessage,
          title: 'Failed',
          btnOkOnPress: () {
            Get.back();
          },
        );
      },
      (r) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: r,
          title: 'Done',
          btnOkOnPress: () {
            Get.back();
            if (oneDetail ?? false) {
              getOneTicketDetails(ticketId: ticketId!, context: context);
            }
            getTickets(context: context);
          },
        );
      },
    );
  }

  RxInt chipChoice = 0.obs;

  RxList<TransactionModel> sortedList = List<TransactionModel>.empty().obs;
  RxList<TransactionModel> all = List<TransactionModel>.empty().obs;

  getAllTransactions({
    required BuildContext context,
  }) async {
    loadingAllTxn.value = true;
    loadingAllTxnErr.value = false;
    sortedList.value = [];

    final response = await locators.get<UserRepo>().getTransactions();
    loadingAllTxn.value = false;
    response.fold((l) {
      loadingAllTxnErr.value = true;
      AwesomeDialogUtil.error(
        context: context,
        body: l.errMessage,
        title: 'Failed',
        btnOkOnPress: () {
          Get.back();
        },
      );
    }, (r) {
      all.value = r;
      sortedList.value = r;
    });
  }

  sortList({
    required int v,
    DateTime? date,
    String? sender,
    String? reciever,
    int? walletId,
  }) {
    chipChoice.value = v;
    if (v == 4) {
      sortedList.value = all.where((element) {
        return DateTime.parse(element.originalCreationDate).isSameDate(date!);
      }).toList();
    } else if (v == 3) {
      sortedList.value = all.where((element) {
        return element.walletId == walletId;
      }).toList();
    }

    /// it will be 1,2 only
    else {
      sortedList.value = all.where(
        (element) {
          return sender != null
              ? element.sender.fullName
                  .toLowerCase()
                  .contains(sender.toLowerCase())
              : element.recipient.fullName
                  .toLowerCase()
                  .contains(reciever!.toLowerCase());
        },
      ).toList();
    }
  }
}

// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'package:finpay/config/extensions.dart';
import 'package:finpay/config/injection.dart';
import 'package:finpay/config/services/local/cach_helper.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/data/models/group_model.dart';
import 'package:finpay/data/repositories/transfere_repo.dart';
import 'package:finpay/data/repositories/user_repo.dart';
import 'package:finpay/presentation/controller/trade_controller.dart';
import 'package:finpay/presentation/view/transfere/transfer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../core/utils/default_dialog.dart';
import '../../core/utils/default_snackbar.dart';
import '../../data/data_sources/location_service.dart';
import '../../data/models/member_model.dart';
import '../../data/models/transaction_code_details_model.dart';
import '../../data/models/transaction_model.dart';
import '../../data/models/wallet_model.dart';
import '../view/home/topup/top_up_screen.dart';
import '../view/home/transaction_details.dart';
import '../view/profile/widget/transaction_code_details.dart';
import '../view/transfere/transfer_sucess_screen.dart';

class HomeController extends GetxController {
  RxList<WalletModel> walletsList = List<WalletModel>.empty(growable: true).obs;
  RxList<WalletModel> allWalletsList = <WalletModel>[].obs;
  RxList<GroupModel> groups = <GroupModel>[].obs;
  RxList<MemberModel> groupMembers = <MemberModel>[].obs;
  RxList<TransactionModel> sortedList = List<TransactionModel>.empty().obs;
  RxInt chipChoice = 0.obs;

  RxBool loadingWallets = false.obs;
  RxBool loadingTransactions = false.obs;
  RxBool loadingGroups = false.obs;
  RxBool loadingGroupMembers = false.obs;

  RxBool loadingTrasnfere = false.obs;

  RxInt walletIndex = 0.obs;
  RxInt pickedWalletId = 0.obs;
  RxString pickedWalletCurrency = ''.obs;
  RxString pickedWalletName = ''.obs;
  RxBool walletFetchingFailed = false.obs;
  RxBool txnsFetchingFailed = false.obs;
  String? selectedGroupName;
  int? selectedGroupId;
  final method = Method.none.obs;

  getAllWallets({required BuildContext context}) async {
    loadingWallets.value = true;

    final response = await locators.get<UserRepo>().getmyWallets();
    loadingWallets.value = false;

    response.fold((l) {
      walletFetchingFailed.value = true;
      loadingWallets.value = false;
      loadingTransactions.value = false;

      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        title: 'failed',
      );
    }, (r) async {
      allWalletsList.value = r;
      walletsList.value = allWalletsList
          .where((element) => element.hidden.value == false)
          .toList();

      Get.find<TradeController>().walletsList = allWalletsList;
      Get.find<TradeController>().pickedWalletId =
          allWalletsList[0].walletId.obs;
      Get.find<TradeController>().pickedToWalletId =
          allWalletsList[1].walletId.obs;

      loadingWallets.value = false;

      if (walletsList.isNotEmpty) {
        await getWalletTransactions(0);
      }
      loadingTransactions.value = false;
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
        walletIndex.value = 0;
        walletsList.value = allWalletsList
            .where((element) => element.hidden.value == false)
            .toList();
        getWalletTransactions(0);
      },
    );
  }

  customInit(BuildContext context) async {
    walletFetchingFailed = false.obs;
    txnsFetchingFailed = false.obs;
    walletIndex.value = 0;

    loadingTransactions.value = true;
    loadingWallets.value = true;

    getAllWallets(context: context);
  }

  getWalletTransactions(int index) async {
    loadingTransactions.value = true;

    final response = await locators.get<UserRepo>().getTransactions(
          walletId: walletsList[index].walletId.toString(),
        );
    loadingTransactions.value = false;
    response.fold(
      (l) {
        txnsFetchingFailed.value = true;
        return;
      },
      (r) {
        walletsList[index].transactionList = r;
        sortedList.value = r;
      },
    );
  }

  pickWallet(int id) {
    final model = walletsList.firstWhere((element) => element.walletId == id);
    pickedWalletId.value = id;
    pickedWalletCurrency.value = model.currency;
    pickedWalletName.value = model.name;
  }

  pickAllWallet(int id) {
    final model =
        allWalletsList.firstWhere((element) => element.walletId == id);
    pickedWalletId.value = id;
    pickedWalletCurrency.value = model.currency;
    pickedWalletName.value = model.name;
  }

  selectGroup(int id) {
    selectedGroupId = id;

    selectedGroupName = groups.firstWhere((element) => element.id == id).name;
  }

  Future<void> getGroups({required BuildContext context}) async {
    loadingGroups.value = true;

    final response = await locators.get<TransferRepo>().searchGroup();
    loadingGroups.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) {
        groups.value = r;
      },
    );
  }

  RxBool loadingAddGroup = false.obs;
  addGroup(
      {required BuildContext context,
      required String groupName,
      String? groupAbout}) async {
    loadingAddGroup.value = true;

    final response = await locators
        .get<TransferRepo>()
        .addGroup(groupName: groupName, groupAbout: groupAbout);
    loadingAddGroup.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: r,
          title: 'Done',
          btnOkOnPress: () {
            Get.back();
            getGroups(context: context);
          },
        );
      },
    );
  }

  RxBool loadingEditGroup = false.obs;
  editGroup({
    required BuildContext context,
    required String groupName,
    String? groupAbout,
    required String groupId,
  }) async {
    loadingEditGroup.value = true;

    final response = await locators.get<TransferRepo>().editGroup(
          groupName: groupName,
          groupAbout: groupAbout,
          groupId: groupId,
        );
    loadingEditGroup.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: r,
          title: 'Done',
          btnOkOnPress: () {
            Get.back();

            getGroups(context: context);
          },
        );
      },
    );
  }

  deleteGroup({
    required BuildContext context,
    required String groupId,
  }) async {
    loadingEditGroup.value = true;

    final response = await locators.get<TransferRepo>().deleteGroup(
          groupId: groupId,
        );
    loadingEditGroup.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: r,
          title: 'Done',
          btnOkOnPress: () {
            getGroups(context: context);
          },
        );
      },
    );
  }

  RxString err = ''.obs;

  Future<void> getGroupMembers(
      {required BuildContext context, required String groupId}) async {
    loadingGroupMembers.value = true;
    err.value = '';
    final response =
        await locators.get<TransferRepo>().searchGroupMembers(groupId: groupId);
    loadingGroupMembers.value = false;

    response.fold(
      (l) {
        err.value = l.errMessage;
      },
      (r) {
        groupMembers.value = r;
      },
    );
  }

  RxBool loadingEditGroupMember = false.obs;
  RxBool loadingDeleteGroupMember = false.obs;

  deleteGroupMember({
    required BuildContext context,
    required String groupMemberId,
    required String groupId,
  }) async {
    loadingDeleteGroupMember.value = true;

    final response = await locators.get<TransferRepo>().deleteGroupMember(
          groupMemberId: groupMemberId,
        );
    loadingDeleteGroupMember.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: r,
          title: 'Done',
          btnOkOnPress: () async {
            Get.back();
            await Future.wait([
              getGroupMembers(
                context: context,
                groupId: groupId,
              ),
              getGroups(
                context: context,
              ),
            ]);
          },
        );
      },
    );
  }

  editGroupMember({
    required BuildContext context,
    required String groupMemberId,
    required String groupId,
    required String nickName,
  }) async {
    loadingEditGroupMember.value = true;

    final response = await locators.get<TransferRepo>().editGroupMember(
          groupMemberId: groupMemberId,
          groupId: groupId,
          nickName: nickName,
        );
    loadingEditGroupMember.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: r,
          title: 'Done',
          btnOkOnPress: () async {
            Get.back();

            getGroupMembers(
              context: context,
              groupId: groupId,
            );
          },
        );
      },
    );
  }

  addGroupMember({
    required BuildContext context,
    required String userName,
    required String nickName,
    required String groupId,
  }) async {
    loadingEditGroupMember.value = true;

    final response = await locators.get<TransferRepo>().addGroupMember(
          userName: userName,
          nickName: nickName,
          groupId: groupId,
        );
    loadingEditGroupMember.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: r,
          title: 'Done',
          btnOkOnPress: () async {
            Get.back();
            await Future.wait([
              getGroupMembers(
                context: context,
                groupId: groupId,
              ),
              getGroups(context: context),
            ]);
          },
        );
      },
    );
  }

  trasnfereMoney({
    required String type,
    required String money,
    required String walletId,
    required String wallet,
    String? recipient,
    required String amountCurrency,
    String? groupName,
    String? groupId,
    required BuildContext context,
  }) async {
    loadingTrasnfere.value = true;
    final response = await locators.get<TransferRepo>().transfereMoney(
          type: type,
          money: money,
          walletId: walletId,
          recipient: groupId ?? recipient!,
        );
    loadingTrasnfere.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) {
        Get.back();

        Get.to(
          () => TransferSucessScreen(
            type: type,
            money: money,
            amountCurrency: amountCurrency,
            wallet: wallet,
            recipient: groupName ?? recipient!,
            txnNumber: r,
          ),
          transition: Transition.zoom,
          duration: const Duration(
            milliseconds: 500,
          ),
        );
      },
    );
  }

  RxBool loadingDetails = false.obs;
  final trnxModel = Rxn<TransactionModel>();
  getTransactionDetails({
    required String id,
    required BuildContext context,
  }) async {
    loadingDetailsError.value = false;

    trnxModel.value = null;
    loadingDetails.value = true;

    final response =
        await locators.get<UserRepo>().getTransactionDetails(trxnId: id);
    loadingDetails.value = false;

    response.fold(
      (l) {
        loadingDetailsError.value = true;

        Get.back();
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) {
        trnxModel.value = r;
      },
    );
  }

  RxBool loadingCode = false.obs;
  RxString code = ''.obs;
  generateTransfereCode({required BuildContext context}) async {
    loadingCode.value = true;

    final response = await locators.get<TransferRepo>().generateTransfereCode();
    loadingCode.value = false;

    response.fold(
      (l) {
        Get.back();
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) {
        code.value = r;
      },
    );
  }

  RxBool loadingBarCode = false.obs;
  RxString barCode = ''.obs;
  generateUserCode(
      {required BuildContext context,
      required String money,
      required String wallet}) async {
    loadingBarCode.value = true;

    final response = await locators
        .get<TransferRepo>()
        .generateUserBarcode(money: money, wallet: wallet);
    loadingBarCode.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) {
        barCode.value = r;
      },
    );
  }

  RxBool loadingDetailsError = false.obs;
  final trnxDetailsModel = Rxn<TransactionCodeDetailsModel>();

  getTrxnDetailsViaCode({
    required BuildContext context,
    required String code,
    bool? inquireBtn,
    bool? transfereScreen,
    bool? homeView,
  }) async {
    trnxDetailsModel.value = null;
    loadingDetails.value = true;

    final response =
        await locators.get<TransferRepo>().getTrxnDetailsViaCode(code: code);
    loadingDetails.value = false;

    response.fold(
      (l) {
        if (inquireBtn == null) {
          Get.back();
        }
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) {
        trnxDetailsModel.value = r;

        if (transfereScreen ?? false) {
          /// not null means it's username type
          if (r.walletId != null) {
            bool activated =
                walletsList.any((element) => element.walletId == r.walletId!);
            if (!activated) {
              Get.back(result: 'Wallet ${r.walletName} is not activated');
            } else {
              Get.back(result: [code, r]);
            }
          } else {
            Get.back(result: [code, false]);
          }
        } else if (homeView ?? false) {
          if (r.walletId != null) {
            bool activated =
                walletsList.any((element) => element.walletId == r.walletId!);
            if (!activated) {
              Get.back(
                result: 'Wallet ${r.walletName} is not activated',
              );
            } else {
              Get.off(
                TransferScreen(
                  homeResult: [code, r],
                ),
              );
              //Get.back(result: [code, r]);
            }
          } else {
            Get.off(TransferScreen(homeResult: [code, false]));

            // Get.back(result: [code, false]);
          }
        } else {
          if (inquireBtn ?? false) {
            Get.to(
              () => const TransactionCodeDetails(),
              transition: Transition.downToUp,
              duration: const Duration(milliseconds: 400),
            );
          } else {
            //from inquiry qr actn btn screen
            //to remove the current qr Screen
            Get.off(
              () => const TransactionCodeDetails(),
              transition: Transition.downToUp,
              duration: const Duration(milliseconds: 400),
            );
          }
        }
      },
    );
  }

  RxBool loadingInquireDetails = false.obs;

  inquireTransaction({
    required BuildContext context,
    required String number,
  }) async {
    loadingInquireDetails.value = true;

    final response =
        await locators.get<TransferRepo>().getTrxnId(number: number);
    loadingInquireDetails.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'faileeed',
        );
      },
      (r) {
        Get.to(
          () => TransactionDetails(
            txnId: r.toString(),
          ),
          transition: Transition.downToUp,
          duration: const Duration(milliseconds: 500),
        );
      },
    );
  }

  updatePhone({required String phone, required BuildContext context}) async {
    final response = await locators.get<UserRepo>().updatePhone(phone: phone);
    updateError = false;

    response.fold(
      (l) {
        updateError = true;

        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) async {
        try {
          currentUser.phone = phone;
          await CacheHelper.saveSecureData(
            key: 'user',
            value: json.encode(currentUser.toJson()),
          );
        } catch (e) {
          updateError = true;
          if (context.mounted) {
            DefaultSnackbar.snackBar(
              context: context,
              message: e.toString(),
              title: 'failed',
            );
          }
        }
      },
    );
  }

  bool updateError = false;
  updateProfile(
      {required String fullName, required BuildContext context}) async {
    updateError = false;
    final response =
        await locators.get<UserRepo>().updateProfile(fullName: fullName);

    response.fold(
      (l) {
        updateError = true;

        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) async {
        try {
          currentUser.fullName = fullName;
          await CacheHelper.saveSecureData(
            key: 'user',
            value: json.encode(currentUser.toJson()),
          );
        } catch (e) {
          updateError = true;
          if (context.mounted) {
            DefaultSnackbar.snackBar(
              context: context,
              message: e.toString(),
              title: 'failed',
            );
          }
        }
      },
    );
  }

  updateEmail({required String email, required BuildContext context}) async {
    final response = await locators.get<UserRepo>().updateEmail(email: email);
    updateError = false;

    response.fold(
      (l) {
        updateError = true;

        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) async {
        try {
          currentUser.email = email;
          await CacheHelper.saveSecureData(
            key: 'user',
            value: json.encode(currentUser.toJson()),
          );
        } catch (e) {
          updateError = true;
          if (context.mounted) {
            DefaultSnackbar.snackBar(
              context: context,
              message: e.toString(),
              title: 'failed',
            );
          }
        }
      },
    );
  }

  double? latitude, longitude;
  RxBool loadingLocation = false.obs;
  getCurrentLocation({
    required BuildContext context,
  }) async {
    latitude = null;
    longitude = null;
    try {
      loadingLocation.value = true;

      final response = await locators.get<LocationService>().getPosition();
      loadingLocation.value = false;

      if (context.mounted && response is String) {
        DefaultSnackbar.snackBar(
          context: context,
          message: response,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (context.mounted && response is Position) {
        latitude = response.latitude;
        longitude = response.longitude;
      }
      Get.to(
        () => TopUpSCreen(latitude: latitude, longitude: longitude),
        transition: Transition.downToUp,
        duration: const Duration(
          milliseconds: 500,
        ),
      );
    } catch (e) {
      Get.to(
        () => TopUpSCreen(latitude: latitude, longitude: longitude),
        transition: Transition.downToUp,
        duration: const Duration(
          milliseconds: 500,
        ),
      );
      loadingLocation.value = false;

      if (context.mounted) {
        DefaultSnackbar.snackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
  }

  sortList({required int v, DateTime? date, String? sender, String? reciever}) {
    chipChoice.value = v;
    if (v == 3) {
      sortedList.value =
          walletsList[walletIndex.value].transactionList.where((element) {
        return DateTime.parse(element.originalCreationDate).isSameDate(date!);
      }).toList();
    }

    /// it will be 1,2 only
    else {
      sortedList.value = walletsList[walletIndex.value].transactionList.where(
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

  RxBool loadingBookingList = false.obs;
  RxBool loadingEditBookingList = false.obs;

  RxList<MemberModel> membersBook = <MemberModel>[].obs;
  getBookingList() async {
    loadingBookingList.value = true;
    err.value = '';
    final response = await locators.get<UserRepo>().getBookingList();
    loadingBookingList.value = false;

    response.fold(
      (l) {
        err.value = l.errMessage;
      },
      (r) {
        membersBook.value = r;
      },
    );
  }

  addToBookingList(
      {required String username,
      required String nickName,
      required BuildContext context}) async {
    loadingEditBookingList.value = true;
    final response = await locators
        .get<UserRepo>()
        .addToBookingList(username: username, nickName: nickName);
    loadingEditBookingList.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (r) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: r,
          title: 'Done',
          btnOkOnPress: () {
            Get.back();
            getBookingList();
          },
        );
      },
    );
  }

  editBookingList(
      {required String memberId,
      required String nickName,
      required BuildContext context}) async {
    loadingEditBookingList.value = true;
    final response = await locators
        .get<UserRepo>()
        .editBookingList(memberId: memberId, nickName: nickName);
    loadingEditBookingList.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (r) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: r,
          title: 'Done',
          btnOkOnPress: () {
            Get.back();
            getBookingList();
          },
        );
      },
    );
  }

  RxBool loadingDeleteBookingList = false.obs;
  deleteFromBookingList({
    required BuildContext context,
    required String memberId,
  }) async {
    loadingDeleteBookingList.value = true;

    final response = await locators.get<UserRepo>().deleteFromBookingList(
          memberId: memberId,
        );
    loadingDeleteBookingList.value = false;

    response.fold(
      (l) {
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
        );
      },
      (r) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: r,
          title: 'Done',
          btnOkOnPress: () {
            getBookingList();
          },
        );
      },
    );
  }
}

enum Method { none, person, group, code }

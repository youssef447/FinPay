// ignore_for_file: deprecated_member_use

import 'package:finpay/config/injection.dart';
import 'package:finpay/data/models/notification_model.dart';
import 'package:finpay/data/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/default_snackbar.dart';

class NotificationsController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxBool loading = false.obs;
  getNotifications(BuildContext context) async {
    loading.value = true;
    final response = await locators.get<UserRepo>().getMyNotifications();
    loading.value = false;

    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }, (r) {
      notifications.value = r;
    });
  }
}

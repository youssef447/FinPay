// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/textstyle.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DefaultSnackbar {
  DefaultSnackbar._();
  static snackBar({
    required BuildContext context,
    required String message,
     String? title,
    SnackPosition? snackPosition,
    double? radius,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        snackPosition: snackPosition ?? SnackPosition.BOTTOM,
        titleText: Text(
          AppLocalizations.of(context)!.failed,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: HexColor(AppTheme.secondaryColorString!),
              ),
        ),
        message: message,
        backgroundColor: const Color.fromARGB(255, 177, 45, 45),
        duration: const Duration(
          seconds: 2,
        ),
        borderRadius: radius ?? 0,
      ),
    );
  }
}

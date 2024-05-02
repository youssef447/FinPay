// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../style/textstyle.dart';

class AwesomeDialogUtil {
  AwesomeDialogUtil._();
  static sucess({
    required BuildContext context,
    required String body,
    required String title,
    Duration? duration,
    Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: context,
      btnOkText:AppLocalizations.of(context)!.done ,
      dialogBorderRadius: BorderRadius.circular(30),
      body: Text(
        body,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      autoHide: duration,
      title: "VERIFICATION",
      dialogType: DialogType.success,
      padding: const EdgeInsets.all(15),
      btnOkColor: HexColor(AppTheme.primaryColorString!),
      buttonsTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: HexColor(
              AppTheme.secondaryColorString!,
            ),
          ),
      btnOkOnPress: btnOkOnPress ?? () {},
    ).show();
  }

  static error({
    required BuildContext context,
    String? msg,
    required String body,
    required String title,
    Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
            btnOkText:AppLocalizations.of(context)!.done ,

      dialogBorderRadius: BorderRadius.circular(30),
      context: context,
      body: msg == null
          ? Text(
              body,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            )
          : Text(
              "$body , $msg",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
      title: title,
      dialogType: DialogType.error,
      btnOkColor: HexColor(AppTheme.primaryColorString!),
      buttonsTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: HexColor(
              AppTheme.secondaryColorString!,
            ),
          ),
      padding: const EdgeInsets.all(15),
      btnOkOnPress: btnOkOnPress ?? () {},
    ).show();
  }
}

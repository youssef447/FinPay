import 'package:finpay/config/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ValidationHelper {
  ValidationHelper._();

  static String? emailValidation(String email) {
    if (email.isEmpty) {
      return AppLocalizations.of(Get.context!)!.email_required;
    } else if (!email.isValidEmail) {
      return AppLocalizations.of(Get.context!)!.invalid_email;
    }
    return null;
  }

  

  static String? passwordValidation(String password) {
    if (password.isEmpty) {
      return  AppLocalizations.of(Get.context!)!.password_required;
    } else if (password.length < 8) {
      return  AppLocalizations.of(Get.context!)!.password_too_weak;
    } else if (!password.isValidPassword) {
      return  AppLocalizations.of(Get.context!)!.password_format;
    }
    return null;
  }
}

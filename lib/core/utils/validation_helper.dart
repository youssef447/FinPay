import 'package:finpay/config/extensions.dart';

class ValidationHelper {
  ValidationHelper._();

  static String? emailValidation(String email) {
    if (email.isEmpty) {
      return 'email required';
    } else if (!email.isValidEmail) {
      return 'invalid email';
    }
    return null;
  }

  

  static String? passwordValidation(String password) {
    if (password.isEmpty) {
      return 'password required';
    } else if (password.length < 8) {
      return 'password too weak ';
    } else if (!password.isValidPassword) {
      return 'password format not correct';
    }
    return null;
  }
}

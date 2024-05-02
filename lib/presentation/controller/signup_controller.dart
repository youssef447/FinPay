import 'package:finpay/config/injection.dart';
import 'package:finpay/data/repositories/auth_repo.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/default_snackbar.dart';
import '../../widgets/verify_email_screen.dart';

class SignUpController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> pswdController = TextEditingController().obs;
  Rx<TextEditingController> userNameController = TextEditingController().obs;
  RxBool loading = false.obs;

  RxBool isVisible = false.obs;
  RxBool isAgree = false.obs;
  RxBool requiredAgreeMsg = false.obs;

  logUp(BuildContext context) async {
    loading.value = true;
    final response = await locators.get<UserAuthRepo>().logup(
          fullName: nameController.value.text,
          email: emailController.value.text,
          username: userNameController.value.text,
          password: pswdController.value.text,
        );

    response.fold(
      (l) {
        loading.value = false;

        Get.showSnackbar(
          GetSnackBar(
            title: 'Registration Failed',
            message: l.errMessage,
            backgroundColor: Colors.redAccent,
            duration: const Duration(
              seconds: 5,
            ),
          ),
        );
      },
      (r) {
        verifyEmail(context);
      },
    );
  }

  verifyEmail(BuildContext context) async {
    final response = await locators.get<UserAuthRepo>().sendVerificationEmail(
          email: emailController.value.text,
        );

    loading.value = false;
    response.fold(
      (l) {
        emailController.value.text = '';
        pswdController.value.text = '';
        DefaultSnackbar.snackBar(
          context: context,
          message: l.errMessage,
          title: 'failed',
        );
      },
      (r) {
        final email = emailController.value.text;
        final pswd = pswdController.value.text;
        emailController.value.text = '';
        pswdController.value.text = '';

        Get.to(
          () => VerifyEmailScreen(
            email: email,
            userId: r,
            pass: pswd,
          ),
          transition: Transition.rightToLeft,
          duration: const Duration(
            milliseconds: 500,
          ),
        );
      },
    );
  }
}

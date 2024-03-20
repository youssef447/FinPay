import 'package:finpay/config/injection.dart';
import 'package:finpay/core/utils/default_dialog.dart';
import 'package:finpay/data/repositories/auth_repo.dart';
import 'package:finpay/presentation/view/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    loading.value = false;

    response.fold((l) {
      //show failed Message
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
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'sucess',
        btnOkOnPress: () {
          Get.offAll(
            const LoginScreen(),
          );
        },
      );
    });
  }
}

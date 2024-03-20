import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/presentation/view/login/fingerprint_screen.dart';
import 'package:finpay/presentation/view/login/pin_screen.dart';
import 'package:finpay/core/utils/default_snackbar.dart';
import 'package:finpay/widgets/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../config/injection.dart';
import '../../data/repositories/auth_repo.dart';

class LoginController extends GetxController {
//login
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> pswdController = TextEditingController().obs;
  RxBool isVisible = false.obs;
  RxBool loadingLogin = false.obs;
  RxBool loadingSocialLogin = false.obs;

  login({required BuildContext context}) async {
    loadingLogin.value = true;
    final response = await locators.get<UserAuthRepo>().login(
          email: emailController.value.text,
          password: pswdController.value.text,
        );

    response.fold((l) async {
      if (l.errMessage.contains('verify')) {
        final response =
            await locators.get<UserAuthRepo>().sendVerificationEmail(
                  email: emailController.value.text,
                );


        loadingLogin.value = false;
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
            final email=emailController.value.text;
            final pswd=pswdController.value.text;
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
      } else {
        loadingLogin.value = false;
        DefaultSnackbar.snackBar(
            context: context, message: l.errMessage, title: 'Login failed');
      }
    }, (r) {
      loadingLogin.value = false;
      emailController.value.text = '';
      pswdController.value.text = '';
      Get.offAll(
        () => const VerifyPinScreen(),
        transition: Transition.rightToLeft,
        duration: const Duration(
          milliseconds: 500,
        ),
      );
    });
  }

  socialLogin({required String email, required BuildContext context}) async {
    loadingSocialLogin.value = true;

    final response = await locators.get<UserAuthRepo>().socialLogin(
          email: email,
        );

    response.fold((l) async {
      if (l.errMessage.contains('verify')) {
        final response =
            await locators.get<UserAuthRepo>().sendVerificationEmail(
                  email: emailController.value.text,
                );
        loadingSocialLogin.value = false;

        response.fold((l) {
          DefaultSnackbar.snackBar(
            context: context,
            message: l.errMessage,
            title: 'failed',
          );
        }, (r) {
          loadingSocialLogin.value = false;

          Get.to(
            () => const FingerPrintScreen(),
            transition: Transition.rightToLeft,
            duration: const Duration(
              milliseconds: 500,
            ),
          );
        });
      } else {
        loadingSocialLogin.value = false;
        DefaultSnackbar.snackBar(
            context: context, message: l.errMessage, title: 'Login failed');
      }
    }, (r) {
      loadingSocialLogin.value = false;

      currentUser = r;
      Get.to(
        () => const VerifyPinScreen(),
        transition: Transition.rightToLeft,
        duration: const Duration(
          milliseconds: 500,
        ),
      );
    });
  }
}

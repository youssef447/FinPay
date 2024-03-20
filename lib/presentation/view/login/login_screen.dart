// ignore_for_file: deprecated_member_use

import 'package:finpay/core/utils/validation_helper.dart';
import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/presentation/controller/login_controller.dart';
import 'package:finpay/presentation/view/login/password_recovery_screen.dart';
import 'package:finpay/presentation/view/signup/signup_screen.dart';
import 'package:finpay/widgets/custom_button.dart';
import 'package:finpay/widgets/custom_textformfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/style/textstyle.dart';
import '../../../widgets/indicator_loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    loginController.isVisible.value = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: InkWell(
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            if (FocusScope.of(context).hasFocus) {
              FocusScope.of(context).unfocus();
            }
          },
          child: Container(
            color: AppTheme.isLightTheme == false
                ? const Color(0xff15141F)
                : const Color(0xffFFFFFF),
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: AppBar().preferredSize.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Icon(Icons.arrow_back),
                  const SizedBox(
                    height: 38,
                  ),
                  Text(
                    "Hi Welcome Back!",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Sign in to your account",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xffA2A0A8),
                        ),
                  ),

                  Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              Obx(() {
                                return CustomTextFormField(
                                  focusNode: _focusNodes[0],
                                  prefix: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Icon(
                                      Icons.email,
                                      color: _focusNodes[0].hasFocus
                                          ? HexColor(
                                              AppTheme.primaryColorString!)
                                          : const Color(0xffA2A0A8),
                                    ),
                                  ),
                                  hintText: "Email Address",
                                  inputType: TextInputType.emailAddress,
                                  textEditingController:
                                      loginController.emailController.value,
                                  validator: (value) {
                                    return ValidationHelper.emailValidation(
                                      value!,
                                    );
                                  },
                                );
                              }),
                              const SizedBox(height: 24),
                              Obx(() {
                                return CustomTextFormField(
                                  
                                  focusNode: _focusNodes[1],
                                  sufix: InkWell(
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      loginController.isVisible.value =
                                          !loginController.isVisible.value;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Icon(
                                          loginController.isVisible.value
                                              ? Icons.visibility_off_outlined
                                              : Icons.remove_red_eye),
                                    ),
                                  ),
                                  prefix: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: SvgPicture.asset(
                                      DefaultImages.pswd,
                                      color: _focusNodes[1].hasFocus
                                          ? HexColor(
                                              AppTheme.primaryColorString!)
                                          : const Color(0xffA2A0A8),
                                    ),
                                  ),
                                  hintText: "Password",
                                  obscure:
                                      loginController.isVisible.value == true
                                          ? false
                                          : true,
                                  textEditingController:
                                      loginController.pswdController.value,
                                  inputType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    return ValidationHelper.passwordValidation(
                                      value!,
                                    );
                                  },
                                );
                              }),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      Get.to(
                                        const PasswordRecoveryScreen(),
                                        transition: Transition.rightToLeft,
                                        duration:
                                            const Duration(milliseconds: 500),
                                      );
                                    },
                                    child: Text(
                                      "Forgot your password?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: HexColor(
                                                AppTheme.primaryColorString!),
                                          ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 32),
                              Obx(
                                () => loginController.loadingLogin.value
                                    ? const IndicatorBlurLoading()
                                    : InkWell(
                                        focusColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          if (FocusScope.of(context).hasFocus) {
                                            FocusScope.of(context).unfocus();
                                          }
                                          if (formKey.currentState!
                                              .validate()) {
                                            loginController.login(
                                              context: context,
                                            );
                                          }
                                        },
                                        child: customButton(
                                          HexColor(
                                              AppTheme.primaryColorString!),
                                          "Login",
                                          HexColor(
                                              AppTheme.secondaryColorString!),
                                          context,
                                        ),
                                      ),
                              ),
                              InkWell(
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Get.to(
                                    () => const SignUpScreen(),
                                    transition: Transition.rightToLeft,
                                    duration: const Duration(milliseconds: 500),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Don’t have account?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color:
                                                      const Color(0xff9CA3AF))),
                                      Text(" Sign Up",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: HexColor(AppTheme
                                                    .primaryColorString!),
                                              ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: const Color(0xffE8E8E8),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0, right: 16),
                              child: Text("Or login with"),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: const Color(0xffE8E8E8),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Obx(
                          () => loginController.loadingSocialLogin.value
                              ? const IndicatorBlurLoading()
                              : Container(
                                  height: 56,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffE8E8E8)),
                                    borderRadius: BorderRadius.circular(16),
                                    color: HexColor(
                                        AppTheme.secondaryColorString!),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 17.0),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          DefaultImages.facebook,
                                          height: 50,
                                          width: 40,
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          focusColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            loginController.socialLogin(
                                              email: 'abdlokman123@gmail.com',
                                              context: context,
                                            );
                                          },
                                          child: Text(
                                            "Login with Facebook",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color:
                                                      const Color(0xff15141F),
                                                ),
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

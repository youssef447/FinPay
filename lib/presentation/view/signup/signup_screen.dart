// ignore_for_file: avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/utils/validation_helper.dart';
import 'package:finpay/presentation/controller/signup_controller.dart';
import 'package:finpay/presentation/view/login/login_screen.dart';
import 'package:finpay/widgets/custom_button.dart';
import 'package:finpay/widgets/custom_textformfield.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/style/textstyle.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpController = Get.put(SignUpController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    signUpController.isVisible.value = false;
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
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
            FocusScope.of(context).requestFocus(FocusNode());
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
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      DefaultImages.finalLogo,
                      height: 110,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.getting_started,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    AppLocalizations.of(context)!.create_acc_to_continue,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xffA2A0A8),
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //   const SizedBox(height: 20),
                              CustomTextFormField(
                                autoValidate: true,
                                focusNode: _focusNodes[0],
                                prefix: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: SvgPicture.asset(
                                    DefaultImages.userName,
                                    color: _focusNodes[0].hasFocus
                                        ? HexColor(AppTheme.primaryColorString!)
                                        : const Color(0xffA2A0A8),
                                    // color:  HexColor(AppTheme.secondaryColorString!)
                                  ),
                                ),
                                hintText:
                                    AppLocalizations.of(context)!.full_name,
                                inputType: TextInputType.text,
                                textEditingController:
                                    signUpController.nameController.value,
                                validator: (val) {
                                  if (val == null) {
                                    return AppLocalizations.of(context)!
                                        .full_name_required;
                                  }
                                  if (val.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .full_name_required;
                                  }
                                  if (val.length < 6) {
                                    return AppLocalizations.of(context)!
                                        .full_name_should_be_more_than_6_characters;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              CustomTextFormField(
                                autoValidate: true,
                                focusNode: _focusNodes[1],
                                prefix: Icon(
                                  Icons.email,
                                  color: _focusNodes[1].hasFocus
                                      ? HexColor(AppTheme.primaryColorString!)
                                      : const Color(0xffA2A0A8),
                                  // color:  HexColor(AppTheme.secondaryColorString!)
                                ),
                                hintText:
                                    AppLocalizations.of(context)!.email_address,
                                inputType: TextInputType.emailAddress,
                                textEditingController:
                                    signUpController.emailController.value,
                                capitalization: TextCapitalization.none,
                                validator: (val) {
                                  return ValidationHelper.emailValidation(val!);
                                },
                              ),
                              const SizedBox(height: 24),
                              CustomTextFormField(
                                autoValidate: true,
                                focusNode: _focusNodes[2],
                                prefix: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: SvgPicture.asset(
                                    DefaultImages.userName,
                                    color: _focusNodes[2].hasFocus
                                        ? HexColor(AppTheme.primaryColorString!)
                                        : const Color(0xffA2A0A8),
                                    // color:  HexColor(AppTheme.secondaryColorString!)
                                  ),
                                ),
                                hintText:
                                    AppLocalizations.of(context)!.user_name,
                                inputType: TextInputType.name,
                                textEditingController:
                                    signUpController.userNameController.value,
                                validator: (val) {
                                  if (val == null) {
                                    return AppLocalizations.of(context)!
                                        .user_name_required;
                                  }
                                  if (val.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .user_name_required;
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 24),
                              Obx(() {
                                return CustomTextFormField(
                                  focusNode: _focusNodes[3],
                                  sufix: InkWell(
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      signUpController.isVisible.value =
                                          !signUpController.isVisible.value;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: SvgPicture.asset(
                                        DefaultImages.eye,
                                      ),
                                    ),
                                  ),
                                  prefix: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: SvgPicture.asset(
                                      DefaultImages.pswd,
                                      color: _focusNodes[3].hasFocus
                                          ? HexColor(
                                              AppTheme.primaryColorString!)
                                          : const Color(0xffA2A0A8),
                                    ),
                                  ),
                                  hintText:
                                      AppLocalizations.of(context)!.password,
                                  obscure:
                                      signUpController.isVisible.value == true
                                          ? false
                                          : true,
                                  textEditingController:
                                      signUpController.pswdController.value,
                                  capitalization: TextCapitalization.none,
                                  limit: [
                                    FilteringTextInputFormatter
                                        .singleLineFormatter,
                                  ],
                                  inputType: TextInputType.visiblePassword,
                                  validator: (val) {
                                    return ValidationHelper.passwordValidation(
                                        val!);
                                  },
                                );
                              }),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => InkWell(
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        signUpController.isAgree.value =
                                            !signUpController.isAgree.value;
                                      },
                                      child: Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xffDCDBE0)),
                                            color:
                                                signUpController.isAgree.value
                                                    ? HexColor(AppTheme
                                                        .primaryColorString!)
                                                    : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Icon(
                                          Icons.check,
                                          size: 15,
                                          color: signUpController.isAgree.value
                                              ? Colors.white
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                      child: RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .by_creating,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: AppTheme.isLightTheme ==
                                                        false
                                                    ? const Color(0xffA2A0A8)
                                                    : const Color(0xff211F32),
                                              ),
                                        ),
                                        TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .terms,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: HexColor(
                                                  AppTheme.primaryColorString!,
                                                ),
                                              ),
                                        ),
                                        TextSpan(
                                          text:
                                              AppLocalizations.of(context)!.and,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: AppTheme.isLightTheme ==
                                                        false
                                                    ? const Color(0xffA2A0A8)
                                                    : const Color(0xff211F32),
                                              ),
                                        ),
                                        TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .conditions,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: HexColor(
                                                  AppTheme.primaryColorString!,
                                                ),
                                              ),
                                        ),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              Obx(
                                () => Visibility(
                                  visible:
                                      signUpController.requiredAgreeMsg.value,
                                  child: Text(
                                    AppLocalizations.of(context)!.must_agree,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: const Color.fromARGB(
                                              255, 156, 35, 26),
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 17),
                              Obx(
                                () => signUpController.loading.value
                                    ? const Center(
                                        child: IndicatorBlurLoading())
                                    : InkWell(
                                        focusColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          signUpController
                                                  .requiredAgreeMsg.value =
                                              !signUpController.isAgree.value;
                                          if (formKey.currentState!
                                                  .validate() &&
                                              signUpController.isAgree.value) {
                                            signUpController.logUp(context);
                                          }
                                        },
                                        child: customButton(
                                            HexColor(
                                                AppTheme.primaryColorString!),
                                            AppLocalizations.of(context)!
                                                .sign_up_Now,
                                            HexColor(
                                                AppTheme.secondaryColorString!),
                                            context),
                                      ),
                              ),
                              InkWell(
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Get.to(
                                    () => const LoginScreen(),
                                    transition: Transition.rightToLeft,
                                    duration: const Duration(milliseconds: 500),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .already_have_an_account,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: const Color(0xff9CA3AF),
                                            ),
                                      ),
                                      Text(
                                          " ${AppLocalizations.of(context)!.login}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: HexColor(
                                                  AppTheme.primaryColorString!,
                                                ),
                                              ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
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

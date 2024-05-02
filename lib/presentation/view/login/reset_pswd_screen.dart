// ignore_for_file: avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/pass_reset_controller.dart';
import 'package:finpay/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/validation_helper.dart';
import '../../../widgets/custom_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? email, code;
  final bool? settings;
  const ResetPasswordScreen(
      {Key? key,  this.email,  this.code, this.settings})
      : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _pass1 = TextEditingController();
  final TextEditingController _pass2 = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final pswdResetController = Get.put(
    PasswordResetController(),
  );
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    pswdResetController.isNewVisible.value = false;
    pswdResetController.isConfirmVisible.value = false;
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
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          color: AppTheme.isLightTheme == false
              ? const Color(0xff15141F)
              : const Color(0xffFFFFFF),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back)),
                const Spacer(),
                Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.reset_your_password,
                          style:
                              Theme.of(context).textTheme.headlineLarge!.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                  ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                         AppLocalizations.of(context)!.at_least,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: const Color(0xffA2A0A8),
                                  ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Obx(
                          () => CustomTextFormField(
                            focusNode: _focusNodes[0],
                            sufix: InkWell(
                              onTap: () {
                                pswdResetController.isNewVisible.value =
                                    !pswdResetController.isNewVisible.value;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Icon(
                                    pswdResetController.isNewVisible.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.remove_red_eye
                                    ),
                              ),
                            ),
                            prefix: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset(
                                DefaultImages.pswd,
                                color: _focusNodes[0].hasFocus
                                    ? HexColor(AppTheme.primaryColorString!)
                                    : const Color(0xffA2A0A8),
                              ),
                            ),
                            hintText:  AppLocalizations.of(context)!.new_password,
                            obscure:
                                pswdResetController.isNewVisible.value == true
                                    ? false
                                    : true,
                            textEditingController: _pass1,
                            capitalization: TextCapitalization.none,
                            limit: [
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            inputType: TextInputType.visiblePassword,
                            validator: (val) {
                              return ValidationHelper.passwordValidation(val!);
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        Obx(
                          () => CustomTextFormField(
                            focusNode: _focusNodes[1],
                            sufix: InkWell(
                              onTap: () {
                                pswdResetController.isConfirmVisible.value =
                                    !pswdResetController.isConfirmVisible.value;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Icon(
                                    pswdResetController.isConfirmVisible.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.remove_red_eye),
                              ),
                            ),
                            prefix: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset(
                                DefaultImages.pswd,
                                color: _focusNodes[1].hasFocus
                                    ? HexColor(AppTheme.primaryColorString!)
                                    : const Color(0xffA2A0A8),
                              ),
                            ),
                            hintText:  AppLocalizations.of(context)!.confirm_password,
                            obscure:
                                pswdResetController.isConfirmVisible.value ==
                                        true
                                    ? false
                                    : true,
                            textEditingController: _pass2,
                            capitalization: TextCapitalization.none,
                            inputType: TextInputType.visiblePassword,
                            validator: (val) {
                              if (val != _pass1.text) {
                                return  AppLocalizations.of(context)!.password_must_match;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Obx(
                          () => pswdResetController.loadingReset.value
                              ? const CircularProgressIndicator.adaptive()
                              : InkWell(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (widget.settings ?? false) {
                                         pswdResetController.updatePassword(
                                       
                                          pass: _pass1.text,
                                        );
                                      } else {
                                        pswdResetController.resetPassword(
                                          email: widget.email!,
                                          code: widget.code!,
                                          password: _pass1.text,
                                        );
                                      }
                                    }
                                  },
                                  child: customButton(
                                      HexColor(AppTheme.primaryColorString!),
                                      AppLocalizations.of(context)!.continue_,
                                      HexColor(AppTheme.secondaryColorString!),
                                      context),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/core/utils/validation_helper.dart';
import 'package:finpay/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/custom_button.dart';
import '../../controller/pass_reset_controller.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({Key? key}) : super(key: key);

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  final pswdResetController = Get.put(
    PasswordResetController(),
  );
  final FocusNode _focusNodes = FocusNode();

  @override
  void initState() {
    _focusNodes.addListener(() {
      setState(() {});
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
              padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back)),
                  const Spacer(),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.password_recovery,
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
                          AppLocalizations.of(context)!.password_recovery_msg,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: const Color(0xffA2A0A8)),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Form(
                          key: _formKey,
                          child: CustomTextFormField(
                            focusNode: _focusNodes,
                            prefix: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset(
                                DefaultImages.phone,
                                color: _focusNodes.hasFocus
                                    ? HexColor(AppTheme.primaryColorString!)
                                    : const Color(0xffA2A0A8),
                                // color:  HexColor(AppTheme.secondaryColorString!)
                              ),
                            ),
                            hintText:
                                AppLocalizations.of(context)!.email_address,
                            inputType: TextInputType.emailAddress,
                            textEditingController: emailController,
                            capitalization: TextCapitalization.none,
                            validator: (val) {
                              return ValidationHelper.emailValidation(val!);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              pswdResetController.sendPasswordResetEmail(
                                email: emailController.text,
                              );
                            }
                          },
                          child: customButton(
                              HexColor(AppTheme.primaryColorString!),
                              AppLocalizations.of(context)!.continue_,
                              HexColor(AppTheme.secondaryColorString!),
                              context),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

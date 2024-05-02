// ignore_for_file: avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'package:finpay/core/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../presentation/controller/verify_email_controller.dart';
import 'custom_button.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email, userId, pass;
  const VerifyEmailScreen({
    Key? key,
    required this.email,
    required this.userId,
    required this.pass,
  }) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController _pinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final verifyEmailController = Get.put(
    VerifyEmailController(),
  );
  final defaultPinTheme = PinTheme(
    width: 66,
    height: 66,
    textStyle: TextStyle(
        fontSize: 32,
        color: AppTheme.isLightTheme == false
            ? Colors.white
            : const Color(0xff15141F),
        fontWeight: FontWeight.w800),
    decoration: BoxDecoration(
      color: AppTheme.isLightTheme == false
          ? const Color(0xff211F32)
          : const Color(0xffF9F9FA),
      //border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(16),
    ),
  );

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.verify_your_identity,
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        AppLocalizations.of(context)!.we_sent_code_to,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: const Color(0xffA2A0A8),
                            ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.email,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Form(
                        key: _formKey,
                        child: Pinput(
                          controller: _pinController,
                          defaultPinTheme: defaultPinTheme,
                          length: 6,
                          validator: (val) {
                            if (val == null) {
                              return AppLocalizations.of(context)!.pin_fill_msg;
                            }
                            if (val.length < 6) {
                              return AppLocalizations.of(context)!.pin_fill_msg;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Obx(
                        () => verifyEmailController.loadingVerify.value
                            ? const CircularProgressIndicator.adaptive()
                            : InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    verifyEmailController.verifyEmailCode(
                                      context: context,
                                      email: widget.email,
                                      pass: widget.pass,
                                      userId: widget.userId,
                                      code: _pinController.text,
                                    );
                                  }
                                },
                                child: customButton(
                                  HexColor(AppTheme.primaryColorString!),
                                  AppLocalizations.of(context)!.continue_,
                                  HexColor(AppTheme.secondaryColorString!),
                                  context,
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.didnt_recieve_email,
                            style:
                                Theme.of(context).textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => verifyEmailController.loadingResend.value
                                ? const CircularProgressIndicator.adaptive()
                                : GestureDetector(
                                    onTap: () {
                                      verifyEmailController.resendCode(
                                          email: widget.email,
                                          context: context);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.resend,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: HexColor(
                                              AppTheme.primaryColorString!,
                                            ),
                                          ),
                                    )),
                          )
                        ],
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
    );
  }
}

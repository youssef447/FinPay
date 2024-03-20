// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../widgets/custom_button.dart';
import '../../controller/pass_reset_controller.dart';

class VerifyResetPswdScreen extends StatefulWidget {
  final String email;
  final bool? resetPin,transfere;
  const VerifyResetPswdScreen({Key? key, required this.email, this.resetPin, this.transfere})
      : super(key: key);

  @override
  State<VerifyResetPswdScreen> createState() => _VerifyResetPswdScreenState();
}

class _VerifyResetPswdScreenState extends State<VerifyResetPswdScreen> {
  final TextEditingController _pinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final pswdResetController = Get.put(
    PasswordResetController(),
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
                        "Verify your identity",
                        style:
                            Theme.of(context).textTheme.headline6!.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "We have just sent a code to",
                        style:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xffA2A0A8),
                                ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.email,
                        style:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
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
                            if (val!.length < 6) {
                              return 'Please fill the 6 fields';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Obx(
                        () => pswdResetController.loadingVerify.value
                            ? const CircularProgressIndicator.adaptive()
                            : InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    pswdResetController.verifyResetCode(
                                      email: widget.email,
                                      code: _pinController.text,
                                      resetPin: widget.resetPin,
                                      transfere:widget.transfere,
                                    );
                                  }
                                },
                                child: customButton(
                                  HexColor(AppTheme.primaryColorString!),
                                  "Continue",
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
                            'didn\'t recieve email ?',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => pswdResetController.loadingResend.value
                                ? const IndicatorBlurLoading()
                                : GestureDetector(
                                    onTap: () {
                                      pswdResetController.resendCode(
                                        email: widget.email,
                                        context: context,
                                      );
                                    },
                                    child: Text(
                                      'Resend',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
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

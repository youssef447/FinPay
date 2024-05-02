// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/pin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/indicator_loading.dart';

class TransferePinScreen extends StatefulWidget {
  const TransferePinScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TransferePinScreen> createState() => _TransferePinScreenState();
}

class _TransferePinScreenState extends State<TransferePinScreen> {
  late final TextEditingController _pinController;
  late final GlobalKey<FormState> _formKey;

  late final PinController pinController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pinController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    pinController = Get.put(PinController());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pinController.dispose();
    pinController.dispose();

    _formKey.currentState?.dispose();
  }

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
      borderRadius: BorderRadius.circular(16),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppTheme.isLightTheme ? Colors.black : Colors.white,
        backgroundColor: AppTheme.isLightTheme == false
            ? const Color(0xff15141F)
            : Colors.white,
      ),
      backgroundColor: AppTheme.isLightTheme == false
          ? const Color(0xff15141F)
          : Colors.white,
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 15,
              ),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.verify_pin_payment,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    AppLocalizations.of(context)!.enterPin,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                        ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Form(
                    key: _formKey,
                    child: Pinput(
                      defaultPinTheme: defaultPinTheme,
                      controller: _pinController,
                      length: 6,
                      validator: (val) {
                        if (val!.length < 6) {
                          return AppLocalizations.of(context)!.pin_fill_msg;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.i_forgot_my_pin,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Obx(
                        () => pinController.loadingReset.value
                            ? const IndicatorBlurLoading()
                            : GestureDetector(
                                onTap: () {
                                  pinController.resetPin(
                                    context: context,
                                    transfere: true,
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.reset,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: HexColor(
                                          AppTheme.primaryColorString!,
                                        ),
                                      ),
                                ),
                              ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Obx(
                    () => pinController.loading.value
                        ? const IndicatorBlurLoading()
                        : InkWell(
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                pinController.verifyPinTransfere(
                                  pin: _pinController.text,
                                  context: context,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

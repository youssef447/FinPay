// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/pin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/indicator_loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifyPinScreen extends StatefulWidget {
  const VerifyPinScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyPinScreen> createState() => _VerifyPinScreenState();
}

class _VerifyPinScreenState extends State<VerifyPinScreen> {
  final TextEditingController _pinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final pinController = Get.put(PinController());

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
        leading: GestureDetector(
          child: Icon(Icons.logout_rounded),
          onTap: () {
            pinController.logout(context: context);
          },
        ),
        backgroundColor: AppTheme.isLightTheme == false
            ? const Color(0xff15141F)
            : Colors.white,
      ),
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
                : Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: AppBar().preferredSize.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.enterPin,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
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
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
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
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.reset,
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
                                    pinController.verifyPin(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

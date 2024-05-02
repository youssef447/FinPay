// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/presentation/controller/pin_controller.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/custom_button.dart';

class CreatePinScreen extends StatefulWidget {
  final bool? transfere;

  const CreatePinScreen({Key? key, this.transfere}) : super(key: key);

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _pinController = TextEditingController();
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
        foregroundColor:
            AppTheme.isLightTheme == false ? Colors.white : Colors.black,
        backgroundColor: AppTheme.isLightTheme == false
            ? const Color(0xff15141F)
            : Colors.white,
      ),
      body: InkWell(
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
              : Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.create_a_pin_code,
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
                        AppLocalizations.of(context)!.create_pin_msg,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:
                                  Theme.of(context).textTheme.titleLarge!.color,
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
                                    widget.transfere ?? false
                                        ? pinController.createPinTransfere(
                                            pin: _pinController.text,
                                            userId: currentUser.id.toString(),
                                            context: context,
                                          )
                                        : pinController.createPin(
                                            pin: _pinController.text,
                                            userId: currentUser.id.toString(),
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
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

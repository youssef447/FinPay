// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/presentation/controller/pin_controller.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../widgets/custom_button.dart';

class CreatePinScreen extends StatefulWidget {
  final bool? resetPin, transfere;

  const CreatePinScreen({Key? key, this.resetPin,  this.transfere})
      : super(key: key);

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
      appBar: AppBar(),
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
                        "Create New Pin",
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
                        "Add a pin number to make your wallet more secure",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:
                                  Theme.of(context).textTheme.caption!.color,
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
                                            reset: widget.resetPin,
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

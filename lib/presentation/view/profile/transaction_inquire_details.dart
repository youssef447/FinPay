import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textformfield.dart';
import '../../../widgets/indicator_loading.dart';
import '../home/widget/qr_scanner.dart';

class TransactionInquireDetails extends StatefulWidget {
  const TransactionInquireDetails({super.key});

  @override
  State<TransactionInquireDetails> createState() =>
      _TransactionInquireDetailsState();
}

class _TransactionInquireDetailsState
    extends State<TransactionInquireDetails> {
  final codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.isLightTheme == false
                ? const Color(0xff323045)
                : Theme.of(context).canvasColor, /*  AppTheme.isLightTheme == false
          ? const Color(0xff211F32)
          : Colors.white.withOpacity(0.9), */
      appBar: AppBar(
        foregroundColor: AppTheme.isLightTheme ? Colors.black : Colors.white,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.inquire_details,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_rounded),
            onPressed: () async {
              String? qrCode = await Get.to(() => const QrScannerView());
              if (qrCode != null) {
                codeController.text = qrCode;
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: Get.height * 0.6,
          width: Get.width * 0.9,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color:  AppTheme.isLightTheme == false
          ? const Color(0xff211F32)
          : HexColor(AppTheme.primaryColorString!).withOpacity(0.7),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                'assets/images/transaction.svg',
                height: Get.height * 0.6 * 0.2,
                width: 40,
              ),
              Form(
                key: formKey,
                child: CustomTextFormField(
                  fillColor: AppTheme.isLightTheme==false? const Color(0xff323045):Theme.of(context).canvasColor.withOpacity(0.7),
                  hintText: AppLocalizations.of(context)!.code,
                  prefix: Icon(
                    Icons.code,
                    color: AppTheme.isLightTheme
                        ? HexColor(AppTheme.primaryColorString!)
                        : Colors.white,
                  ),
                  textEditingController: codeController,
                  autoValidate: false,
                  inputType: TextInputType.text,
                  validator: (val) {
                    if (val!.trim().isEmpty) {
                      return 'code required';
                    }
                    return null;
                  },
                ),
              ),
              Obx(
                () => homeController.loadingDetails.value
                    ? const IndicatorBlurLoading()
                    : GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            homeController.getTrxnDetailsViaCode(
                              context: context,
                              code: codeController.text,
                            );
                          }
                        },
                        child: customButton(
                          HexColor(AppTheme.primaryColorString!),
                          AppLocalizations.of(context)!.inquire,
                          HexColor(AppTheme.secondaryColorString!),
                          context,
                          width: Get.width / 2.5,
                          height: 40,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

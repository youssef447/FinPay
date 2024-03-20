// ignore_for_file: deprecated_member_use

import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/presentation/view/home/widget/qr_code_Screen.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/style/textstyle.dart';

class TransferCodeReqScreen extends StatefulWidget {
  const TransferCodeReqScreen({
    super.key,
  });

  @override
  State<TransferCodeReqScreen> createState() => _TransferCodeReqScreenState();
}

class _TransferCodeReqScreenState extends State<TransferCodeReqScreen> {
  final controller = Get.find<HomeController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.generateTransfereCode(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.5,
      width: Get.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppTheme.isLightTheme == false
            ? const Color(0xff323045)
            : Theme.of(context).canvasColor.withOpacity(0.95),
      ),
      child: Obx(
        () => controller.loadingCode.value
            ? const Center(
                child: IndicatorBlurLoading(),
              )
            : QrCodeScreen(
                code: controller.code.value,
                onGenerateTap: () {
                  controller.generateTransfereCode(context: context);
                },
              ),
      ),
    );
  }
}

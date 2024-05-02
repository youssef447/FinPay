// ignore_for_file: deprecated_member_use

import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/style/textstyle.dart';

import 'package:finpay/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/custom_textformfield.dart';
import '../../../widgets/indicator_loading.dart';
import '../../controller/home_controller.dart';
import '../home/widget/qr_code_Screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransferRequestScreen extends StatefulWidget {
  const TransferRequestScreen({Key? key}) : super(key: key);

  @override
  State<TransferRequestScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferRequestScreen> {
  final homeController = Get.find<HomeController>();
  final amountController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    amountController.dispose();
    formKey.currentState?.dispose();
  }

  @override
  void initState() {
    super.initState();
    homeController.barCode.value = '';
    homeController.code.value = '';

    homeController.method.value = Method.none;
    homeController.pickedWalletId.value =
        homeController.walletsList[homeController.walletIndex.value].walletId;

    homeController.pickedWalletCurrency.value =
        homeController.walletsList[homeController.walletIndex.value].currency;
    homeController.pickedWalletName.value =
        homeController.walletsList[homeController.walletIndex.value].name;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> choices = [
      Row(
        children: [
          Icon(
            Icons.person,
            color: AppTheme.isLightTheme == false
                ? HexColor('#A2A0A8')
                : HexColor(AppTheme.primaryColorString!),
          ),
          const SizedBox(
            width: 14,
          ),
          Text(
            AppLocalizations.of(context)!.user_name,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .color!
                    .withOpacity(0.60)),
          ),
        ],
      ),
      Row(
        children: [
          Icon(
            Icons.code_rounded,
            color: AppTheme.isLightTheme == false
                ? HexColor('#A2A0A8')
                : HexColor(AppTheme.primaryColorString!),
          ),
          const SizedBox(
            width: 14,
          ),
          Text(
            AppLocalizations.of(context)!.transfer_code,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .color!
                    .withOpacity(0.60)),
          )
        ],
      ),
    ];
    return Scaffold(
      backgroundColor: AppTheme.isLightTheme == false
          ? HexColor('#15141f')
          : HexColor(AppTheme.primaryColorString!),
      appBar: AppBar(
        clipBehavior: Clip.hardEdge,
        foregroundColor: Colors.white,
        backgroundColor: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : HexColor(AppTheme.primaryColorString!),
        title: Text(
          AppLocalizations.of(context)!.request,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.white,
              ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        clipBehavior: Clip.hardEdge,
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppTheme.isLightTheme == false
              ? const Color(0xff211F32)
              : Theme.of(context).appBarTheme.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.request_transfere_by,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 75),
              PopupMenuButton<Method>(
                initialValue: homeController.method.value,
                constraints: BoxConstraints(minWidth: Get.width * 0.9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                position: PopupMenuPosition.under,
                onSelected: (value) {
                  homeController.barCode.value = '';

                  FocusScope.of(context).requestFocus(
                    FocusNode(),
                  );

                  if (value == Method.code) {
                    homeController.generateTransfereCode(
                      context: context,
                    );
                  }
                  formKey.currentState?.reset();

                  homeController.method.value = value;
                },
                itemBuilder: ((context) {
                  return [
                    PopupMenuItem(
                      value: Method.person,
                      child: choices[0],
                    ),
                    PopupMenuItem(
                      value: Method.code,
                      child: choices[1],
                    ),
                  ];
                }),
                child: Obx(
                  () => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.isLightTheme == false
                          ? const Color(0xff323045)
                          : HexColor(AppTheme.primaryColorString!)
                              .withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: homeController.method.value == Method.person
                        ? Row(
                            children: [
                              choices[0],
                              const Spacer(),
                              const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 25,
                              ),
                            ],
                          )
                        : homeController.method.value == Method.code
                            ? Row(
                                children: [
                                  choices[1],
                                  const Spacer(),
                                  const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: 25,
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                      height: 24,
                                      child: SvgPicture.asset(
                                        DefaultImages.card,
                                        fit: BoxFit.fill,
                                        color: AppTheme.isLightTheme == false
                                            ? HexColor('#A2A0A8')
                                            : HexColor(
                                                AppTheme.primaryColorString!,
                                              ),
                                      )),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.select_method,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context)
                                              .textTheme
                                              .headlineLarge!
                                              .color!
                                              .withOpacity(
                                                0.60,
                                              ),
                                        ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: 25,
                                  ),
                                ],
                              ),
                  ),
                ),
              ),
              const SizedBox(
                height: 75,
              ),
              Obx(
                () => homeController.method.value == Method.none
                    ? Lottie.asset(
                        DefaultImages.transfereImage,
                        frameRate: const FrameRate(100),
                        height: 300,
                      )
                    : homeController.method.value == Method.person
                        ? homeController.loadingBarCode.value
                            ? const Center(
                                child: IndicatorBlurLoading(),
                              )
                            : homeController.barCode.value.isNotEmpty
                                ? QrCodeScreen(
                                    code: homeController.barCode.value,
                                    onGenerateTap: () {
                                      homeController.generateUserCode(
                                        context: context,
                                        money: amountController.text,
                                        wallet: homeController
                                            .pickedWalletId.value
                                            .toString(),
                                      );
                                    },
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: AppTheme.isLightTheme == false
                                              ? const Color(0xff323045)
                                              : HexColor(
                                                  AppTheme.primaryColorString!,
                                                ),
                                        ),
                                        width: double.infinity,
                                        child: Obx(
                                          () => DropdownButtonHideUnderline(
                                            child: DropdownButton<int>(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              value: homeController
                                                  .pickedWalletId.value,
                                              iconEnabledColor: Colors.white,
                                              dropdownColor:
                                                  AppTheme.isLightTheme == false
                                                      ? const Color(0xff323045)
                                                      : HexColor(AppTheme
                                                          .primaryColorString!),
                                              items: homeController.walletsList
                                                  .map(
                                                (e) {
                                                  return DropdownMenuItem(
                                                    value: e.walletId,
                                                    child: Text(
                                                      e.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge!
                                                          .copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (value) {
                                                homeController
                                                    .pickWallet(value!);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 75,
                                      ),
                                      Form(
                                        key: formKey,
                                        child: CustomTextFormField(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .price,
                                          textEditingController:
                                              amountController,
                                          inputType: TextInputType.number,
                                          limit: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          autoValidate: false,
                                          prefix: Obx(
                                            () => Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                homeController
                                                    .pickedWalletCurrency.value,
                                                style: TextStyle(
                                                  color: HexColor(AppTheme
                                                      .primaryColorString!),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .amount_required;
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 75,
                                      ),
                                      Obx(
                                        () => homeController.method.value ==
                                                    Method.none ||
                                                homeController.method.value ==
                                                    Method.code
                                            ? const SizedBox()
                                            : GestureDetector(
                                                onTap: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    homeController
                                                        .generateUserCode(
                                                      context: context,
                                                      money:
                                                          amountController.text,
                                                      wallet: homeController
                                                          .pickedWalletId.value
                                                          .toString(),
                                                    );
                                                  }
                                                },
                                                child: customButton(
                                                  HexColor(AppTheme
                                                      .primaryColorString!),
                                                  AppLocalizations.of(context)!
                                                      .request,
                                                  HexColor(AppTheme
                                                      .secondaryColorString!),
                                                  context,
                                                  width: Get.width / 3.3,
                                                  height: 40,
                                                ),
                                              ),
                                      )
                                    ],
                                  )
                        : homeController.loadingCode.value
                            ? const Center(
                                child: IndicatorBlurLoading(),
                              )
                            : QrCodeScreen(
                                code: homeController.code.value,
                                onGenerateTap: () {
                                  homeController.generateTransfereCode(
                                    context: context,
                                  );
                                },
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

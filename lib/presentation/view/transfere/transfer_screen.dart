// ignore_for_file: deprecated_member_use

import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/style/textstyle.dart';

import 'package:finpay/presentation/view/transfere/transfere_info.dart';
import 'package:finpay/presentation/view/home/widget/qr_scanner.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controller/home_controller.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final homeController = Get.find<HomeController>();
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    codeController.dispose();
    formKey.currentState?.dispose();
  }

  @override
  void initState() {
    super.initState();
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
            AppLocalizations.of(context)!.person,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context)
                    .textTheme
                    .headline6!
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
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context)
                    .textTheme
                    .headline6!
                    .color!
                    .withOpacity(0.60)),
          )
        ],
      ),
      Row(
        children: [
          Icon(
            Icons.group_outlined,
            color: AppTheme.isLightTheme == false
                ? HexColor('#A2A0A8')
                : HexColor(AppTheme.primaryColorString!),
          ),
          const SizedBox(
            width: 14,
          ),
          Text(
            AppLocalizations.of(context)!.group,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context)
                    .textTheme
                    .headline6!
                    .color!
                    .withOpacity(0.60)),
          ),
        ],
      ),
    ];
    return Scaffold(
      backgroundColor: AppTheme.isLightTheme == false
          ? HexColor('#15141f')
          : HexColor(AppTheme.primaryColorString!),
      appBar: AppBar(
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
        clipBehavior: Clip.hardEdge,
        foregroundColor: Colors.white,
        backgroundColor: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : HexColor(AppTheme.primaryColorString!),
        title: Text(
           AppLocalizations.of(context)!.transfer,
          style: Theme.of(context).textTheme.headline6!.copyWith(
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
                 AppLocalizations.of(context)!.to_who_transfere,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              PopupMenuButton<Method>(
                initialValue: homeController.method.value,
                constraints: BoxConstraints(minWidth: Get.width * 0.9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                position: PopupMenuPosition.under,
                onSelected: (value) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  formKey.currentState?.reset();
                  if (value == Method.group) {
                    if (homeController.groups.isEmpty) {
                      homeController.getGroups(context: context);
                    }
                  }

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
                    PopupMenuItem(
                      value: Method.group,
                      child: choices[2],
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
                            : homeController.method.value == Method.group
                                ? Row(
                                    children: [
                                      choices[2],
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
                                            color:
                                                AppTheme.isLightTheme == false
                                                    ? HexColor('#A2A0A8')
                                                    : HexColor(AppTheme
                                                        .primaryColorString!),
                                          )),
                                      const SizedBox(width: 14),
                                      Text(
                                         AppLocalizations.of(context)!.select_method,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .color!
                                                  .withOpacity(0.60),
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
              const SizedBox(height: 50),
              Obx(
                () => homeController.method.value == Method.none
                    ? Lottie.asset(
                        DefaultImages.transfereImage,
                        frameRate: const FrameRate(100),
                        height: 300,
                      )
                    : homeController.method.value == Method.person
                        ? TransfereInfo(
                            hintText:  AppLocalizations.of(context)!.person_name,
                            nameController: nameController,
                            formKey: formKey,
                          )
                        : homeController.method.value == Method.code
                            ? TransfereInfo(
                              isCode:true,
                                hintText:  AppLocalizations.of(context)!.code,
                                codeController: codeController,
                                formKey: formKey,
                              )
                            : TransfereInfo(
                                hintText:  AppLocalizations.of(context)!.group,
                                isGroup: true,
                                formKey: formKey,
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/presentation/view/transfere/transfere_pin_screen.dart';
import 'package:finpay/widgets/custom_container.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget transferDialog({
  required BuildContext context,
  required String recipient,
  required String amount,
  String? groupId,
  required String wallet,
  required String walletId,
  required String type,
  required String amountCurrency,
  required HomeController homeController,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 50),
    child: Container(
      height: 349,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppTheme.isLightTheme == false
            ? const Color(0xff211F32)
            : Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: HexColor(AppTheme.primaryColorString!),
                    size: 20,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.confirm,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.transparent,
                    size: 25,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.receiver,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffA2A0A8)),
                ),
                Text(
                  '#$recipient',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Divider(
              color: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .color!
                  .withOpacity(0.08),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.transfer_with,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffA2A0A8)),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      DefaultImages.card,
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      wallet,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 5),
            Divider(
              color: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .color!
                  .withOpacity(0.08),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.transfer_amount,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffA2A0A8)),
                ),
                Text(
                  '$amountCurrency $amount',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Divider(
              color: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .color!
                  .withOpacity(0.08),
            ),
            const SizedBox(height: 20),
            Obx(
              () => homeController.loadingTrasnfere.value
                  ? const IndicatorBlurLoading()
                  : CustomButton(
                      title: AppLocalizations.of(context)!.pay,
                      onTap: () async {
                        if (currentUser.pinCodeRequired == 1) {
                         // Get.back();
                          final bool? verified = await Get.to(
                            () => const TransferePinScreen(),
                            transition: Transition.downToUp,
                            duration: const Duration(milliseconds: 500),
                          );
                          if (verified ?? false) {
                            if (context.mounted) {
                              homeController.trasnfereMoney(
                                type: type,
                                money: amount,
                                walletId: walletId,
                                wallet: wallet,
                                recipient: recipient,
                                groupId: groupId,
                                context: context,
                                amountCurrency: amountCurrency,
                                groupName: recipient,
                              );
                            }
                          }
                        } else {
                          homeController.trasnfereMoney(
                            type: type,
                            money: amount,
                            walletId: walletId,
                            wallet: wallet,
                            recipient: recipient,
                            groupId: groupId,
                            context: context,
                            amountCurrency: amountCurrency,
                            groupName: recipient,
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ignore_for_file: deprecated_member_use

import 'package:finpay/core/utils/funcs.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/widgets/custom_button.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/style/textstyle.dart';
import '../../../core/utils/default_dialog.dart';
import '../../../core/utils/default_snackbar.dart';

class TransactionDetails extends StatefulWidget {
  final String? txnId;
  const TransactionDetails({
    super.key,
    this.txnId,
  });

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  final controller = Get.find<HomeController>();
  bool loadingShare = false;
  bool loadingPrint = false;

  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getTransactionDetails(id: widget.txnId!, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor:
            AppTheme.isLightTheme == false ? Colors.white : Colors.black,
        title: Text(
          AppLocalizations.of(context)!.transaction_details,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(),
        ),
      ),
      backgroundColor: AppTheme.isLightTheme == false
          ? const Color(0xff211F32)
          : Colors.white,
      body: SafeArea(
        child: Obx(
          () => Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              RepaintBoundary(
                key: globalKey,
                child: Center(
                  child: controller.loadingDetails.value
                      ? const IndicatorBlurLoading()
                      : controller.loadingDetailsError.value
                          ? Text(
                              AppLocalizations.of(context)!.err,
                            )
                          : Container(
                              height: Get.height * 0.6,
                              width: Get.width * 0.9,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppTheme.isLightTheme == false
                                    ? const Color(0xff323045)
                                    : HexColor(AppTheme.secondaryColorString!),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.6 * 0.12,
                                      ),
                                      Text(
                                        '#${controller.trnxModel.value!.transactionNumber}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontSize: 12,
                                            ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text: controller.trnxModel.value!
                                                  .transactionNumber,
                                            ),
                                          );
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.copy,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                letterSpacing: 1,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                  255,
                                                  54,
                                                  81,
                                                  74,
                                                ),
                                              ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.price,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      const Color(0xffA2A0A8),
                                                ),
                                          ),
                                          Text(
                                            controller.trnxModel.value!.amount,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .sender,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                        0xffA2A0A8)),
                                          ),
                                          Text(
                                            controller.trnxModel.value!.sender
                                                .fullName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .receiver,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                        0xffA2A0A8)),
                                          ),
                                          Text(
                                            controller.trnxModel.value!
                                                .recipient.fullName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .wallet,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                        0xffA2A0A8)),
                                          ),
                                          Text(
                                            '${controller.trnxModel.value!.walletCurrency} ${controller.trnxModel.value!.walletName}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.type,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                        0xffA2A0A8)),
                                          ),
                                          Text(
                                            controller.trnxModel.value!
                                                .transactionType,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.date,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                        0xffA2A0A8)),
                                          ),
                                          Text(
                                            controller
                                                .trnxModel.value!.creationDate
                                                .split(', ')[0],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.time,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                        0xffA2A0A8)),
                                          ),
                                          Text(
                                            controller
                                                .trnxModel.value!.creationDate
                                                .split(', ')[1],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                  Positioned(
                                    top: -45,
                                    child: SvgPicture.asset(
                                      'assets/images/transaction.svg',
                                      height: Get.height * 0.6 * 0.2,
                                      width: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          loadingShare = true;
                        });
                        final RenderRepaintBoundary boundary =
                            globalKey.currentContext?.findRenderObject()
                                as RenderRepaintBoundary;
                        try {
                          await captureAndShare(boundary: boundary);
                          setState(() {
                            loadingShare = false;
                          });
                        } catch (e) {
                          setState(() {
                            loadingShare = false;
                          });
                          if (context.mounted) {
                            DefaultSnackbar.snackBar(
                                context: context, message: e.toString());
                          }
                        }
                      },
                      icon: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppTheme.isLightTheme
                            ? HexColor(AppTheme.primaryColorString!)
                            : Colors.white,
                        child: loadingShare
                            ? const IndicatorBlurLoading()
                            : Icon(
                                Icons.share_outlined,
                                color: AppTheme.isLightTheme
                                    ? Colors.white
                                    : HexColor(
                                        AppTheme.primaryColorString!,
                                      ),
                              ),
                      ),
                    ),
                    loadingPrint
                        ? const IndicatorBlurLoading()
                        : GestureDetector(
                            onTap: () async {
                              setState(() {
                                loadingPrint = true;
                              });
                              final RenderRepaintBoundary boundary =
                                  globalKey.currentContext?.findRenderObject()
                                      as RenderRepaintBoundary;
                              try {
                                await captureAndShare(
                                    boundary: boundary, save: true);
                                setState(() {
                                  loadingPrint = false;
                                });
                                if (context.mounted) {
                                  AwesomeDialogUtil.sucess(
                                    context: context,
                                    body: AppLocalizations.of(context)!
                                        .receipt_saved,
                                    title: 'Done',
                                    duration: const Duration(seconds: 2),
                                  );
                                }
                              } catch (e) {
                                setState(() {
                                  loadingPrint = false;
                                });
                                if (context.mounted) {
                                  DefaultSnackbar.snackBar(
                                    context: context,
                                    message: e.toString(),
                                  );
                                }
                              }
                            },
                            child: customButton(
                              AppTheme.isLightTheme
                                  ? HexColor(AppTheme.primaryColorString!)
                                  : Colors.white,
                              AppLocalizations.of(context)!.print,
                              AppTheme.isLightTheme
                                  ? Colors.white
                                  : Colors.black,
                              context,
                              width: Get.width / 3,
                              height: 40,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/style/textstyle.dart';

class TransactionDetails extends StatefulWidget {
  final String? txnId;
  const TransactionDetails(
      {super.key,  this.txnId,});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  final controller = Get.find<HomeController>();
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
          'Transaction Details',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(),
        ),
      ),
      backgroundColor: AppTheme.isLightTheme == false
          ? const Color(0xff211F32)
          : Colors.white.withOpacity(0.9),
      body: SafeArea(
        child: Obx(
          () => Center(
            child: controller.loadingDetails.value
                ? const IndicatorBlurLoading()
                : controller.loadingDetailsError.value ?const Text('error Occue'): Container(
                    height: Get.height * 0.6,
                    width: Get.width * 0.9,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppTheme.isLightTheme == false
                          ? const Color(0xff323045)
                          : Theme.of(context).canvasColor.withOpacity(0.95),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          'assets/images/transaction.svg',
                          height: Get.height * 0.6 * 0.2,
                          width: 40,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '#${controller.trnxModel.value!.transactionNumber}',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "amount",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xffA2A0A8)),
                                ),
                                Text(
                                  controller.trnxModel.value!.amount,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
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
                                  .headline6!
                                  .color!
                                  .withOpacity(0.08),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sender",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xffA2A0A8)),
                                ),
                                Text(
                                  controller.trnxModel.value!.sender.fullName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
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
                                  .headline6!
                                  .color!
                                  .withOpacity(0.08),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Reciever",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xffA2A0A8)),
                                ),
                                Text(
                                  controller
                                      .trnxModel.value!.recipient.fullName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
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
                                  .headline6!
                                  .color!
                                  .withOpacity(0.08),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Wallet",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xffA2A0A8)),
                                ),
                                Text(
                                  '${controller.trnxModel.value!.walletCurrency} ${controller.trnxModel.value!.walletName}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
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
                                  .headline6!
                                  .color!
                                  .withOpacity(0.08),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xffA2A0A8)),
                                ),
                                Text(
                                  controller.trnxModel.value!.creationDate
                                      .split(', ')[0],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
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
                                  .headline6!
                                  .color!
                                  .withOpacity(0.08),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Time",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xffA2A0A8)),
                                ),
                                Text(
                                  controller.trnxModel.value!.creationDate
                                      .split(', ')[1],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                )
                              ],
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

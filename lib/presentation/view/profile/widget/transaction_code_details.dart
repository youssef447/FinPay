// ignore_for_file: deprecated_member_use

import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/style/textstyle.dart';

class TransactionCodeDetails extends StatefulWidget {
  const TransactionCodeDetails({
    super.key,
  });

  @override
  State<TransactionCodeDetails> createState() => _TransactionCodeDetailsState();
}

class _TransactionCodeDetailsState extends State<TransactionCodeDetails> {
  final controller = Get.find<HomeController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            child: Container(
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
                    controller.trnxDetailsModel.value!.username ?? 'N/A',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 20,
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
                            controller.trnxDetailsModel.value!.amount != null
                                ? '${controller.trnxDetailsModel.value!.amount} ${controller.trnxDetailsModel.value!.walletCurrency}'
                                : 'N/A',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
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
                            '${controller.trnxDetailsModel.value!.walletCurrency ?? 'N/A'} ${controller.trnxDetailsModel.value!.walletName ?? 'N/A'}'
                            '',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
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
                            "type",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xffA2A0A8)),
                          ),
                          Text(
                            controller.trnxDetailsModel.value!.type ?? 'N/A',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
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

// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/trade_controller.dart';
import 'package:finpay/presentation/view/home/widget/trader_list.dart';
import 'package:finpay/presentation/view/trade/dashboard.dart';
import 'package:finpay/presentation/view/trade/join_trade_screen.dart';
import 'package:finpay/widgets/custom_button.dart';
import 'package:finpay/widgets/no_data_screen.dart';
import 'package:finpay/widgets/shimmer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'exchange_screen.dart';

class TradeView extends StatelessWidget {
  final TradeController tradeController;
  const TradeView({super.key, required this.tradeController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () {
          return tradeController.getTrades(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Obx(
            () => tradeController.traderServicesModel.isEmpty
                ? NoDataScreen(
                    onRefresh: () {
                      tradeController.getTrades(context);
                    },
                    title: 'No Available Tradements',
                  )
                : tradeController.error.value.isNotEmpty
                    ? Center(
                        child: TextButton(
                          onPressed: () {
                            tradeController.getTrades(context);
                          },
                          child: Text(
                            '${tradeController.error.value}, Tap to Refresh',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .color,
                                ),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.tradments,
                            style: Theme.of(Get.context!)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                  letterSpacing: 2,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          SizedBox(
                            height: AppBar().preferredSize.height / 3.5,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                if (tradeController.traderModel.value == null) {
                                  Get.bottomSheet(
                                    const JoinAsTrader(),
                                  );
                                } else {
                                  Get.to(
                                    () => DashBoard(
                                      tradeController: tradeController,
                                    ),
                                    duration: const Duration(milliseconds: 500),
                                    transition: Transition.downToUp,
                                  );
                                }
                              },
                              child: customButton(
                                HexColor(AppTheme.primaryColorString!),
                                tradeController.traderModel.value == null
                                    ? AppLocalizations.of(context)!.be_trader
                                    : AppLocalizations.of(context)!.dashboard,
                                HexColor(AppTheme.secondaryColorString!),
                                context,
                                width: Get.width / 2.7,
                                height: 40,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Expanded(
                            child: tradeController.loading.value
                                ? const ShimmerListView(length: 10)
                                : ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 10,
                                    ),
                                    itemCount: tradeController
                                        .traderServicesModel.length,
                                    padding: const EdgeInsets.only(bottom: 10),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.bottomSheet(
                                            ExchangeScreen(
                                              tradeController: tradeController,
                                              tradeId: tradeController
                                                  .traderServicesModel[index].id
                                                  .toString(),
                                              traderName: tradeController
                                                  .traderServicesModel[index]
                                                  .traderName,
                                              fromWallet: tradeController
                                                  .traderServicesModel[index]
                                                  .fromWalletCurrency,
                                              toWallet: tradeController
                                                  .traderServicesModel[index]
                                                  .toWalletCurrency,
                                              exchangeRate: tradeController
                                                  .traderServicesModel[index]
                                                  .exchangeRate,
                                            ),
                                          );
                                        },
                                        child: TraderList(
                                          color: AppTheme.isLightTheme == false
                                              ? const Color(0xff211F32)
                                              : HexColor(AppTheme
                                                      .primaryColorString!)
                                                  .withOpacity(0.9),
                                          activated: tradeController
                                              .traderServicesModel[index]
                                              .active,
                                          price:
                                              ' ${tradeController.traderServicesModel[index].traderAmount} ${tradeController.traderServicesModel[index].fromWalletCurrency}',
                                          title: tradeController
                                              .traderServicesModel[index]
                                              .traderName,
                                          subtitle: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  AutoSizeText(
                                                    '${tradeController.traderServicesModel[index].fromWalletName} ${tradeController.traderServicesModel[index].fromWalletCurrency}',
                                                    maxLines: 2,
                                                    style: Theme.of(
                                                            Get.context!)
                                                        .textTheme
                                                        .caption!
                                                        .copyWith(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                  const Icon(
                                                    Icons
                                                        .keyboard_double_arrow_right_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  AutoSizeText(
                                                    '${tradeController.traderServicesModel[index].toWalletName} ${tradeController.traderServicesModel[index].toWalletCurrency}',
                                                    maxLines: 2,
                                                    style: Theme.of(
                                                            Get.context!)
                                                        .textTheme
                                                        .caption!
                                                        .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  AutoSizeText(
                                                    '1',
                                                    maxLines: 2,
                                                    style: Theme.of(
                                                            Get.context!)
                                                        .textTheme
                                                        .caption!
                                                        .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                  const Icon(
                                                    Icons
                                                        .keyboard_double_arrow_right_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  AutoSizeText(
                                                    ' ${tradeController.traderServicesModel[index].exchangeRate}',
                                                    maxLines: 2,
                                                    style: Theme.of(
                                                            Get.context!)
                                                        .textTheme
                                                        .caption!
                                                        .copyWith(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          time: tradeController
                                              .traderServicesModel[index]
                                              .creationTime,
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}

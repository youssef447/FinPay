// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/presentation/controller/trade_controller.dart';
import 'package:finpay/presentation/view/home/widget/trader_list.dart';
import 'package:finpay/presentation/view/trade/dashboard.dart';
import 'package:finpay/presentation/view/trade/join_trade_screen.dart';
import 'package:finpay/presentation/view/trade/widgets/custom_container.dart';
import 'package:finpay/widgets/custom_button.dart';
import 'package:finpay/widgets/no_data_screen.dart';
import 'package:finpay/widgets/shimmer_list_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'exchange_screen.dart';

class TradeView extends StatefulWidget {
  final TradeController tradeController;

  TradeView({
    super.key,
    required this.tradeController,
  });

  @override
  State<TradeView> createState() => _TradeViewState();
}

class _TradeViewState extends State<TradeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () {
          return widget.tradeController.getTrades(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Obx(
            () => CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.tradments,
                      style:
                          Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
                                letterSpacing: 2,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppBar().preferredSize.height / 3.5,
                  ),
                ),
                widget.tradeController.loading.value ||
                        Get.find<HomeController>().loadingWallets.value
                    ? const SliverFillRemaining(
                        child: ShimmerListView(length: 10))
                    : widget.tradeController.error.value.isNotEmpty
                        ? SliverToBoxAdapter(
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  widget.tradeController.getTrades(context);
                                },
                                child: Text(
                                  '${widget.tradeController.error.value}, Tap to Refresh',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .color,
                                      ),
                                ),
                              ),
                            ),
                          )
                        : widget.tradeController.traderServicesModel.isEmpty
                            ? SliverToBoxAdapter(
                                child: Center(
                                  child: NoDataScreen(
                                    onRefresh: () {
                                      widget.tradeController.getTrades(context);
                                    },
                                    title: AppLocalizations.of(context)!
                                        .no_trades_at_all,
                                  ),
                                ),
                              )
                            : SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    widget.tradeController.walletsList.isEmpty
                                        ? const SizedBox()
                                        : CustomContainer(),
                                    const SizedBox(
                                      height: 55,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (widget.tradeController.traderModel
                                                .value ==
                                            null) {
                                          Get.bottomSheet(
                                            const JoinAsTrader(),
                                          );
                                        } else {
                                          Get.to(
                                            () => DashBoard(
                                              tradeController:
                                                  widget.tradeController,
                                            ),
                                            duration: const Duration(
                                              milliseconds: 500,
                                            ),
                                            transition: Transition.downToUp,
                                          );
                                        }
                                      },
                                      child: customButton(
                                        AppTheme.isLightTheme == false
                                            ? Color(0xff211F32)
                                            : HexColor(
                                                AppTheme.primaryColorString!),
                                        widget.tradeController.traderModel
                                                    .value ==
                                                null
                                            ? AppLocalizations.of(context)!
                                                .be_trader
                                            : AppLocalizations.of(context)!
                                                .dashboard,
                                        HexColor(
                                            AppTheme.secondaryColorString!),
                                        context,
                                        width: Get.width / 2.7,
                                        height: 40,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    widget.tradeController.walletsList.isEmpty
                                        ? const SizedBox()
                                        : Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .pick_wallet,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .color,
                                                    ),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              DropdownMenu<int>(
                                                hintText: AppLocalizations.of(
                                                        context)!
                                                    .all,

                                                ///selected color
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge!
                                                    .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppTheme.isLightTheme
                                                              ? Colors.black
                                                              : Colors.white,
                                                    ),
                                                expandedInsets: EdgeInsets.zero,
                                                onSelected: (value) {
                                                  widget.tradeController
                                                      .sortTrades(value!);
                                                },
                                                menuStyle: MenuStyle(
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    AppTheme.isLightTheme ==
                                                            false
                                                        ? const Color(
                                                            0xff323045)
                                                        : Colors.white,
                                                  ),
                                                ),
                                                inputDecorationTheme:
                                                    InputDecorationTheme(
                                                        isDense: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 16),
                                                        constraints:
                                                            BoxConstraints
                                                                .tight(
                                                          Size(Get.width * 0.4,
                                                              40),
                                                        ),
                                                        suffixIconColor:
                                                            AppTheme.isLightTheme
                                                                ? Colors.black
                                                                : Colors.white,
                                                        hintStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .headlineLarge!
                                                                .copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppTheme
                                                                          .isLightTheme
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white,
                                                                ),
                                                        filled: true,
                                                        fillColor:
                                                            AppTheme.isLightTheme ==
                                                                    false
                                                                ? const Color(
                                                                    0xff323045)
                                                                : HexColor(
                                                                    AppTheme
                                                                        .secondaryColorString!,
                                                                  ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            16,
                                                          ),
                                                        )),
                                                dropdownMenuEntries: widget
                                                    .tradeController.walletsList
                                                    .map(
                                                  (e) {
                                                    return DropdownMenuEntry(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                          Colors.transparent,
                                                        ),
                                                        foregroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                          AppTheme.isLightTheme
                                                              ? Colors.black
                                                              : Colors.white,
                                                        ),
                                                      ),
                                                      value: e.walletId,
                                                      label: e.name,
                                                    );
                                                  },
                                                ).toList(),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                SliverToBoxAdapter(
                  child: const SizedBox(
                    height: 20,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount:
                        widget.tradeController.sortedTraderServices.length,
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              ExchangeScreen(
                                tradeController: widget.tradeController,
                                tradeId: widget.tradeController
                                    .sortedTraderServices[index].id
                                    .toString(),
                                traderName: widget.tradeController
                                    .sortedTraderServices[index].traderName,
                                fromWallet: widget
                                    .tradeController
                                    .sortedTraderServices[index]
                                    .fromWalletCurrency,
                                toWallet: widget
                                    .tradeController
                                    .sortedTraderServices[index]
                                    .toWalletCurrency,
                                exchangeRate: widget.tradeController
                                    .sortedTraderServices[index].exchangeRate,
                              ),
                            );
                          },
                          child: TraderList(
                            activated: widget.tradeController
                                .sortedTraderServices[index].active,
                            price:
                                ' ${widget.tradeController.sortedTraderServices[index].traderAmount} ${widget.tradeController.sortedTraderServices[index].fromWalletCurrency}',
                            title: widget.tradeController
                                .sortedTraderServices[index].traderName,
                            subtitle: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AutoSizeText(
                                      '${widget.tradeController.sortedTraderServices[index].fromWalletName} ${widget.tradeController.sortedTraderServices[index].fromWalletCurrency}',
                                      maxLines: 2,
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                    ),
                                    const Icon(
                                      Icons
                                          .keyboard_double_arrow_right_outlined,
                                      color: Colors.white,
                                    ),
                                    AutoSizeText(
                                      '${widget.tradeController.sortedTraderServices[index].toWalletName} ${widget.tradeController.sortedTraderServices[index].toWalletCurrency}',
                                      maxLines: 2,
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AutoSizeText(
                                      '1',
                                      maxLines: 2,
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                    ),
                                    const Icon(
                                      Icons
                                          .keyboard_double_arrow_right_outlined,
                                      color: Colors.white,
                                    ),
                                    AutoSizeText(
                                      ' ${widget.tradeController.sortedTraderServices[index].exchangeRate}',
                                      maxLines: 2,
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            time: widget.tradeController
                                .sortedTraderServices[index].creationTime,
                          ),
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

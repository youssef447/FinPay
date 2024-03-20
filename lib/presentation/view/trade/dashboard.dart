// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/trade_controller.dart';
import 'package:finpay/presentation/view/home/widget/trader_list.dart';
import 'package:finpay/presentation/view/trade/add_trade_service.dart';
import 'package:finpay/presentation/view/trade/edit_trade_service.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/globales.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/shimmer_list_view.dart';

class DashBoard extends StatelessWidget {
  final TradeController tradeController;
  const DashBoard({super.key, required this.tradeController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              tradeController.traderModel.value!.myServices.isNotEmpty
                  ? FloatingActionButton(
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'Confirm',
                          middleText:
                              'Are you sure you want to activate all your trades',
                          cancel: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: customButton(
                              Colors.red,
                              'cancel',
                              HexColor(AppTheme.secondaryColorString!),
                              context,
                              width: 100,
                              height: 40,
                            ),
                          ),
                          confirm: GestureDetector(
                            onTap: () {
                              Get.back();
                              tradeController.activateAll(context: context);
                            },
                            child: customButton(
                              HexColor(AppTheme.primaryColorString!),
                              'Yes',
                              HexColor(AppTheme.secondaryColorString!),
                              context,
                              width: 100,
                              height: 40,
                            ),
                          ),
                          confirmTextColor:
                              HexColor(AppTheme.primaryColorString!),
                          cancelTextColor: Colors.red,
                        );
                      },
                      heroTag: 'activate',
                      shape: const CircleBorder(),
                      backgroundColor: Colors.greenAccent,
                      child: const Icon(Icons.done_all_outlined),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              tradeController.traderModel.value!.myServices.isNotEmpty
                  ? FloatingActionButton(
                      heroTag: 'deactivate',
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'Confirm',
                          middleText:
                              'Are you sure you want to deactivate all your trades',
                          cancel: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: customButton(
                              Colors.red,
                              'cancel',
                              HexColor(AppTheme.secondaryColorString!),
                              context,
                              width: 100,
                              height: 40,
                            ),
                          ),
                          confirm: GestureDetector(
                            onTap: () {
                              Get.back();

                              tradeController.deactivateAll(context: context);
                            },
                            child: customButton(
                              HexColor(AppTheme.primaryColorString!),
                              'Yes',
                              HexColor(AppTheme.secondaryColorString!),
                              context,
                              width: 100,
                              height: 40,
                            ),
                          ),
                          confirmTextColor:
                              HexColor(AppTheme.primaryColorString!),
                          cancelTextColor: Colors.red,
                        );
                      },
                      shape: const CircleBorder(),
                      backgroundColor: Colors.red,
                      child: const Icon(Icons.not_interested_outlined),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                heroTag: 'add',
                onPressed: () {
                  Get.bottomSheet(
                    const AddTradeScreen(),
                  );
                },
                shape: const CircleBorder(),
                backgroundColor: HexColor(AppTheme.primaryColorString!),
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppTheme.isLightTheme == false
          ? const Color(0xff15141F)
          : Colors.white,
      appBar: AppBar(
        title: Text(
          'My Tradements',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor:
            AppTheme.isLightTheme == false ? Colors.white : Colors.black,
      ),
      body: SafeArea(
        child: Obx(
          () => tradeController.traderModel.value!.myServices.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.no_trades,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                )
              : tradeController.loading.value
                  ? const ShimmerListView(length: 10)
                  : tradeController.loadingActivation.value
                      ? const Center(child: IndicatorBlurLoading())
                      : ListView.separated(
                          padding: const EdgeInsets.all(15.0),
                          itemBuilder: (context, index) => Stack(
                            alignment: Alignment.topRight,
                            children: [
                              TraderList(
                                activated: tradeController.traderModel.value!
                                    .myServices[index].active,
                                /*  image: tradeController.traderModel.value!
                                    .myServices[index].traderPic, */
                                title: tradeController.traderModel.value!
                                    .myServices[index].traderName,
                                subtitle: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        AutoSizeText(
                                          '${tradeController.traderModel.value!.myServices[index].fromWalletName} ${tradeController.traderModel.value!.myServices[index].fromWalletCurrency}',
                                          maxLines: 2,
                                          style: Theme.of(Get.context!)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                        ),
                                        const Icon(
                                          Icons
                                              .keyboard_double_arrow_right_outlined,
                                          color: Colors.white,
                                        ),
                                        AutoSizeText(
                                          '${tradeController.traderModel.value!.myServices[index].toWalletName} ${tradeController.traderModel.value!.myServices[index].toWalletCurrency}',
                                          maxLines: 2,
                                          style: Theme.of(Get.context!)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
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
                                              .caption!
                                              .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                        ),
                                        const Icon(
                                          Icons
                                              .keyboard_double_arrow_right_outlined,
                                          color: Colors.white,
                                        ),
                                        AutoSizeText(
                                          ' ${tradeController.traderModel.value!.myServices[index].exchangeRate}',
                                          maxLines: 2,
                                          style: Theme.of(Get.context!)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                price:
                                    ' ${tradeController.traderModel.value!.myServices[index].traderAmount} ${tradeController.traderModel.value!.myServices[index].fromWalletCurrency}',
                                time: tradeController.traderModel.value!
                                    .myServices[index].creationTime,
                              ),
                              Positioned(
                                top: -10,
                                right: language == 'ar' ? null: -7,
                                left:language == 'ar' ? -7:null,
                                child: PopupMenuButton(
                                  onSelected: (value) {
                                    if (value == 1) {
                                      Get.bottomSheet(
                                        EditTradeService(
                                          exchangeRate: tradeController
                                              .traderModel
                                              .value!
                                              .myServices[index]
                                              .exchangeRate,
                                          tradeId: tradeController.traderModel
                                              .value!.myServices[index].id
                                              .toString(),
                                        ),
                                      );
                                    } else if (value == 0) {
                                      Get.defaultDialog(
                                        title: 'Confirm',
                                        middleText: tradeController.traderModel
                                                .value!.myServices[index].active
                                            ? 'Are you sure you want to deactivate this trade'
                                            : 'Are you sure you want to activate this trade',
                                        cancel: GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: customButton(
                                            Colors.red,
                                            'cancel',
                                            HexColor(
                                                AppTheme.secondaryColorString!),
                                            context,
                                            width: 100,
                                            height: 40,
                                          ),
                                        ),
                                        confirm: GestureDetector(
                                          onTap: () {
                                            Get.back();

                                            tradeController.traderModel.value!
                                                    .myServices[index].active
                                                ? tradeController
                                                    .deactivateTradeService(
                                                        tradeId:
                                                            tradeController
                                                                .traderModel
                                                                .value!
                                                                .myServices[
                                                                    index]
                                                                .id
                                                                .toString(),
                                                        context: context)
                                                : tradeController
                                                    .activateTradeService(
                                                        tradeId: tradeController
                                                            .traderModel
                                                            .value!
                                                            .myServices[index]
                                                            .id
                                                            .toString(),
                                                        context: context);
                                          },
                                          child: customButton(
                                            HexColor(
                                                AppTheme.primaryColorString!),
                                            'Yes',
                                            HexColor(
                                                AppTheme.secondaryColorString!),
                                            context,
                                            width: 100,
                                            height: 40,
                                          ),
                                        ),
                                        confirmTextColor: HexColor(
                                            AppTheme.primaryColorString!),
                                        cancelTextColor: Colors.red,
                                      );
                                    } else {
                                      Get.defaultDialog(
                                        title: 'Confirm',
                                        middleText:
                                            'Are you sure you want to delete this trade',
                                        cancel: GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: customButton(
                                            Colors.red,
                                            'cancel',
                                            HexColor(
                                                AppTheme.secondaryColorString!),
                                            context,
                                            width: 100,
                                            height: 40,
                                          ),
                                        ),
                                        confirm: GestureDetector(
                                          onTap: () {
                                            Get.back();

                                            tradeController.deleteTradeService(
                                              tradeId: tradeController
                                                  .traderModel
                                                  .value!
                                                  .myServices[index]
                                                  .id
                                                  .toString(),
                                              context: context,
                                            );
                                          },
                                          child: customButton(
                                            HexColor(
                                                AppTheme.primaryColorString!),
                                            'Yes',
                                            HexColor(
                                                AppTheme.secondaryColorString!),
                                            context,
                                            width: 100,
                                            height: 40,
                                          ),
                                        ),
                                        confirmTextColor: HexColor(
                                            AppTheme.primaryColorString!),
                                        cancelTextColor: Colors.red,
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.menu_outlined,
                                    color: Colors.white,
                                  ),
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        value: 0,
                                        child: Text(
                                          tradeController.traderModel.value!
                                                  .myServices[index].active
                                              ? 'Deactivate'
                                              : 'Activate',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                      PopupMenuItem(
                                          value: 1,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.edit_outlined,
                                                color: Colors.green,
                                              ),
                                              Text(
                                                'Edit',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ],
                                          )),
                                      PopupMenuItem(
                                        value: 2,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.delete_outline_rounded,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              'Delete',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ];
                                  },
                                ),
                              ),
                            ],
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                          itemCount: tradeController
                              .traderModel.value!.myServices.length,
                        ),
        ),
      ),
    );
  }
}

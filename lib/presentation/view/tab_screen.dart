// ignore_for_file: unnecessary_new, prefer_const_constructors, unused_field

import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/presentation/controller/services_controller.dart';
import 'package:finpay/presentation/controller/tab_controller.dart';
import 'package:finpay/presentation/view/card/card_view.dart';
import 'package:finpay/presentation/view/home/home_view.dart';
import 'package:finpay/presentation/view/home/widget/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../controller/trade_controller.dart';
import 'services/services_screen.dart';
import 'trade/trade_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late final TabScreenController tabController;

  late final HomeController homeController;
  late final TradeController tradeController;
  late final ServicesController servicesController;

  @override
  void initState() {
    super.initState();
    tabController = Get.put(TabScreenController());
    homeController = Get.put(HomeController());

    tradeController = Get.put(TradeController());

    servicesController = Get.put(ServicesController());
    
    tabController.customInit();
  
    homeController.customInit(context);
    tradeController.getTrades(context);
    servicesController.getServices(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.isLightTheme == false
          ? const Color(0xff15141F)
          : Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => const QrScannerView(
              homeView: true,
            ),
          );
        },
        shape: const CircleBorder(),
        backgroundColor: AppTheme.isLightTheme == false
            ? Color.fromARGB(255, 43, 41, 62)
            : Theme.of(context).appBarTheme.backgroundColor,
        child: Icon(Icons.qr_code_scanner,
            color: AppTheme.isLightTheme
                ? HexColor(AppTheme.primaryColorString!)
                : const Color(0xffA2A0A8)),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : Theme.of(context).appBarTheme.backgroundColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 80,
        shadowColor: Colors.grey,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  tabController.pageIndex.value = 0;
                },
                child: SizedBox(
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        DefaultImages.home,
                        color: tabController.pageIndex.value == 0
                            ? HexColor(AppTheme.primaryColorString!)
                            : AppTheme.isLightTheme == false
                                ? const Color(0xffA2A0A8)
                                : HexColor(AppTheme.primaryColorString!)
                                    .withOpacity(0.4),
                      ),
                      FittedBox(
                        child: Text(
                          AppLocalizations.of(context)!.home,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                fontSize: 12,
                                color: tabController.pageIndex.value == 0
                                    ? HexColor(AppTheme.primaryColorString!)
                                    : AppTheme.isLightTheme == false
                                        ? const Color(0xffA2A0A8)
                                        : HexColor(AppTheme.primaryColorString!)
                                            .withOpacity(0.4),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  tabController.pageIndex.value = 1;
                },
                child: SizedBox(
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.currency_exchange,
                        color: tabController.pageIndex.value == 1
                            ? HexColor(AppTheme.primaryColorString!)
                            : AppTheme.isLightTheme == false
                                ? const Color(0xffA2A0A8)
                                : HexColor(AppTheme.primaryColorString!)
                                    .withOpacity(0.4),
                      ),
                      FittedBox(
                        child: Text(
                          AppLocalizations.of(context)!.tradments,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                fontSize: 12,
                                color: tabController.pageIndex.value == 1
                                    ? HexColor(AppTheme.primaryColorString!)
                                    : AppTheme.isLightTheme == false
                                        ? const Color(0xffA2A0A8)
                                        : HexColor(AppTheme.primaryColorString!)
                                            .withOpacity(0.4),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              InkWell(
                onTap: () {
                  tabController.pageIndex.value = 2;
                },
                child: SizedBox(
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.medical_services_rounded,
                        color: tabController.pageIndex.value == 2
                            ? HexColor(AppTheme.primaryColorString!)
                            : AppTheme.isLightTheme == false
                                ? const Color(0xffA2A0A8)
                                : HexColor(AppTheme.primaryColorString!)
                                    .withOpacity(0.4),
                      ),
                      FittedBox(
                        child: Text(
                          AppLocalizations.of(context)!.services,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                fontSize: 12,
                                color: tabController.pageIndex.value == 2
                                    ? HexColor(AppTheme.primaryColorString!)
                                    : AppTheme.isLightTheme == false
                                        ? const Color(0xffA2A0A8)
                                        : HexColor(AppTheme.primaryColorString!)
                                            .withOpacity(0.4),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  tabController.pageIndex.value = 3;
                },
                child: SizedBox(
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        DefaultImages.card,
                        color: tabController.pageIndex.value == 3
                            ? HexColor(AppTheme.primaryColorString!)
                            : AppTheme.isLightTheme == false
                                ? const Color(0xffA2A0A8)
                                : HexColor(AppTheme.primaryColorString!)
                                    .withOpacity(0.4),
                      ),
                      FittedBox(
                        child: Text(
                          AppLocalizations.of(context)!.wallets,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontSize: 12,
                                    color: tabController.pageIndex.value == 3
                                        ? HexColor(AppTheme.primaryColorString!)
                                        : AppTheme.isLightTheme == false
                                            ? const Color(0xffA2A0A8)
                                            : HexColor(
                                                AppTheme.primaryColorString!,
                                              ).withOpacity(
                                                0.4,
                                              ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => tabController.pageIndex.value == 0
            ? HomeView(homeController: homeController)
            : tabController.pageIndex.value == 1
                ? TradeView(
                    tradeController: tradeController,
                  )
                : tabController.pageIndex.value == 2
                    ? ServiceScreen(
                        servicesController: servicesController,
                      )
                    : CardView(),
      ),
    );
  }
}

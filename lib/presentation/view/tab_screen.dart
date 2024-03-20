// ignore_for_file: unnecessary_new, prefer_const_constructors, unused_field

import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/presentation/controller/services_controller.dart';
import 'package:finpay/presentation/controller/tab_controller.dart';
import 'package:finpay/presentation/view/card/card_view.dart';
import 'package:finpay/presentation/view/home/home_view.dart';
import 'package:finpay/presentation/view/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../controller/card_controller.dart';
import '../controller/trade_controller.dart';
import 'services/services_screen.dart';
import 'trade/trade_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final tabController = Get.put(TabScreenController());
  final homeController = Get.put(HomeController());
  final tradeController = Get.put(TradeController());
  final cardController = Get.put(CardController());
  final servicesController = Get.put(ServicesController());

  @override
  void initState() {
    super.initState();
    tabController.customInit();

    homeController.customInit(context);
    tradeController.getTrades(context);
    cardController.getAllWallets(context: context);
    servicesController.getServices(context);
  }

  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.isLightTheme == false
          ? const Color(0xff15141F)
          : Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        currentIndex: tabController.pageIndex.value,
        onTap: (index) {
          setState(() {
            tabController.pageIndex.value = index;
          });
        },
        backgroundColor: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : Theme.of(context).appBarTheme.backgroundColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppTheme.isLightTheme == false
            ? const Color(0xffA2A0A8)
            : HexColor(AppTheme.primaryColorString!).withOpacity(0.4),
        selectedItemColor: HexColor(AppTheme.primaryColorString!),
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                DefaultImages.home,
                color: tabController.pageIndex.value == 0
                    ? HexColor(AppTheme.primaryColorString!)
                    : AppTheme.isLightTheme == false
                        ? const Color(0xffA2A0A8)
                        : HexColor(AppTheme.primaryColorString!)
                            .withOpacity(0.4),
              ),
            ),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.monetization_on_sharp,
              color: tabController.pageIndex.value == 1
                  ? HexColor(AppTheme.primaryColorString!)
                  : AppTheme.isLightTheme == false
                      ? const Color(0xffA2A0A8)
                      : HexColor(AppTheme.primaryColorString!).withOpacity(0.4),
            ),
            label: AppLocalizations.of(context)!.tradments,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.medical_services_rounded,
              color: tabController.pageIndex.value == 2
                  ? HexColor(AppTheme.primaryColorString!)
                  : AppTheme.isLightTheme == false
                      ? const Color(0xffA2A0A8)
                      : HexColor(AppTheme.primaryColorString!).withOpacity(0.4),
            ),
            label: AppLocalizations.of(context)!.services,
          ),
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  DefaultImages.card,
                  color: tabController.pageIndex.value == 3
                      ? HexColor(AppTheme.primaryColorString!)
                      : AppTheme.isLightTheme == false
                          ? const Color(0xffA2A0A8)
                          : HexColor(AppTheme.primaryColorString!)
                              .withOpacity(0.4),
                ),
              ),
              label: AppLocalizations.of(context)!.wallets),
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  DefaultImages.user,
                  color: tabController.pageIndex.value == 4
                      ? HexColor(AppTheme.primaryColorString!)
                      : AppTheme.isLightTheme == false
                          ? const Color(0xffA2A0A8)
                          : HexColor(AppTheme.primaryColorString!)
                              .withOpacity(0.4),
                ),
              ),
              label:AppLocalizations.of(context)!.profile),
        ],
      ),
      body: GetX<TabScreenController>(
        init: tabController,
        builder: (tabController) => tabController.pageIndex.value == 0
            ? HomeView(homeController: homeController)
            : tabController.pageIndex.value == 1
                ? TradeView(
                    tradeController: tradeController,
                  )
                : tabController.pageIndex.value == 2
                    ? ServiceScreen()
                    : tabController.pageIndex.value == 3
                        ? CardView()
                        : const ProfileView(),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/widgets/shimmer_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/style/images_asset.dart';
import '../../controller/home_controller.dart';
import '../home/widget/debi_card.dart';

class CardView extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  CardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return homeController.getAllWallets(context: context);
      },
      child: Container(
        width: double.infinity,
        color: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.my_cards,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(
                  height: 25,
                ),
                homeController.loadingWallets.value
                    ? Expanded(
                        child: ListView.separated(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            itemBuilder: (context, index) => const SizedBox(
                                  height: 180,
                                  child: ShimmerCard(),
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ),
                            itemCount: 10),
                      )
                    : Expanded(
                        child: homeController.allWalletsList.isEmpty
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Lottie.asset(
                                    DefaultImages.noWallets,
                                    height: 300,
                                    repeat: false,
                                    frameRate: const FrameRate(100),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                              .no_wallets_yet,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 10,
                                ),
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                itemCount: homeController.allWalletsList.length,
                                itemBuilder: (context, index) => ClipRRect(
                                  child: Obx(
                                    () => Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          DebitCard(
                                            walletModel: homeController
                                                .allWalletsList[index],
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Switch.adaptive(
                                              value: !homeController
                                                  .allWalletsList[index]
                                                  .hidden
                                                  .value,
                                              activeColor: HexColor(
                                                  AppTheme.primaryColorString!),
                                              onChanged: (val) {
                                                homeController.toggleWallet(
                                                  val: val,
                                                  context: context,
                                                  currentIndex: index,
                                                );
                                              },
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
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

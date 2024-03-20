// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/presentation/view/home/notifications_screen.dart';
import 'package:finpay/presentation/view/transfere/transfer_screen.dart';
import 'package:finpay/presentation/view/home/widget/circle_card.dart';
import 'package:finpay/presentation/view/home/widget/debi_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/animations/horizontal_fade_transition.dart';
import '../../../core/utils/globales.dart';
import '../../../widgets/default_cached_image.dart';
import '../../../widgets/shimmer_card.dart';
import '../../../widgets/shimmer_list_view.dart';
import 'transaction_details.dart';
import 'transactions_all_list.dart';
import '../transfere/transfere_request.dart';
import 'widget/transaction_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatelessWidget {
  final HomeController homeController;

  const HomeView({Key? key, required this.homeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () {
          return homeController.customInit(context);
        },
        child: Obx(
          () => homeController.walletFetchingFailed.value
              ? Center(
                  child: TextButton(
                    onPressed: () {
                      homeController.customInit(context);
                    },
                    child: Text(
                      'error occured, Tap to refresh',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).textTheme.caption!.color,
                          ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(
                              () => const NotificationScreen(),
                              duration: const Duration(milliseconds: 500),
                              transition: Transition.rightToLeft,
                            );
                          },
                          icon: Icon(
                            Icons.notifications_sharp,
                            size: 30,
                            color: !AppTheme.isLightTheme
                                ? Colors.white
                                : HexColor(
                                    AppTheme.primaryColorString!,
                                  ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.hi,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .color,
                                        ),
                                  ),
                                  AutoSizeText(
                                    maxLines: 1,
                                    currentUser.fullName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            DefaultCachedImage(
                              imgUrl: currentUser.profilePicUrl,
                              height: 50,
                              width: 50,
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 180,
                          width: Get.width,
                          child: homeController.loadingWallets.value
                              ? const ShimmerCard()
                              : homeController.walletsList.isEmpty
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Lottie.asset(
                                          DefaultImages.noWallets,
                                          height: 100,
                                          repeat: false,
                                          frameRate: const FrameRate(100),
                                        ),
                                        Text(
                                          'No wallets added yet',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    )
                                  : Swiper(
                                      pagination: const SwiperPagination(),
                                      index: homeController.walletIndex.value,
                                      itemCount:
                                          homeController.walletsList.length,
                                      viewportFraction: 1,
                                      autoplay: false,
                                      onIndexChanged: (value) {
                                        homeController.walletIndex.value =
                                            value;
                                        homeController
                                            .getWalletTransactions(value);
                                      },
                                      physics: homeController
                                                  .walletsList.length ==
                                              1
                                          ? const NeverScrollableScrollPhysics()
                                          : const AlwaysScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return DebitCard(
                                          walletModel:
                                              homeController.walletsList[index],
                                        );
                                      },
                                    ),
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => homeController.loadingWallets.value
                              ? const SizedBox()
                              : HorizontalFadeTransition(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Stack(
                                        children: [
                                          InkWell(
                                            focusColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: () async {
                                              await homeController
                                                  .getCurrentLocation(
                                                context: context,
                                              );
                                            },
                                            child: circleCard(
                                              image: DefaultImages.topup,
                                              title:
                                                  AppLocalizations.of(context)!
                                                      .topup,
                                            ),
                                          ),
                                          homeController.loadingLocation.value
                                              ? Positioned.fill(
                                                  child: BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                      sigmaX: 2,
                                                      sigmaY: 2,
                                                    ),
                                                    child: const SizedBox(),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                      homeController.walletsList.isEmpty
                                          ? circleCard(
                                              image: DefaultImages.withdraw,
                                              title:
                                                  AppLocalizations.of(context)!
                                                      .withdraw,
                                              color:
                                                  Colors.grey.withOpacity(0.33),
                                            )
                                          : InkWell(
                                              focusColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              splashColor: Colors.transparent,
                                              onTap: () {
                                                Get.to(
                                                  () =>
                                                      const TransferRequestScreen(),
                                                  transition:
                                                      Transition.downToUp,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                );
                                              },
                                              child: circleCard(
                                                image: DefaultImages.withdraw,
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .withdraw,
                                              ),
                                            ),
                                      homeController.walletsList.isEmpty
                                          ? circleCard(
                                              image: DefaultImages.transfer,
                                              title:
                                                  AppLocalizations.of(context)!
                                                      .transfere,
                                              color:
                                                  Colors.grey.withOpacity(0.33),
                                            )
                                          : InkWell(
                                              focusColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              splashColor: Colors.transparent,
                                              onTap: () {
                                                Get.to(
                                                  () => const TransferScreen(),
                                                  transition:
                                                      Transition.downToUp,
                                                  duration: const Duration(
                                                    milliseconds: 500,
                                                  ),
                                                );
                                              },
                                              child: circleCard(
                                                image: DefaultImages.transfer,
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .transfere,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 25,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.isLightTheme == false
                                ? const Color(0xff211F32)
                                : const Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff000000).withOpacity(0.10),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Icon(Icons.drag_handle_outlined),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .transactions,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                      !homeController
                                                  .loadingTransactions.value &&
                                              homeController
                                                  .walletsList.isNotEmpty &&
                                              homeController
                                                  .walletsList[homeController
                                                      .walletIndex.value]
                                                  .transactionList
                                                  .isNotEmpty
                                          ? Text(
                                              '${AppLocalizations.of(context)!.total}: ${homeController.walletsList[homeController.walletIndex.value].transactionList.length}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .caption!
                                                        .color,
                                                  ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                  Visibility(
                                    visible: (!homeController
                                            .loadingTransactions.value &&
                                        homeController.walletsList.isNotEmpty &&
                                        homeController
                                                .walletsList[homeController
                                                    .walletIndex.value]
                                                .transactionList
                                                .length >
                                            1),
                                    child: GestureDetector(
                                      onTap: () {
                                        homeController.chipChoice.value = 0;
                                        homeController.sortedList.value =
                                            homeController
                                                .walletsList[homeController
                                                    .walletIndex.value]
                                                .transactionList;
                                        Get.to(
                                          () => TransactionsAllList(
                                            controller: homeController,
                                          ),
                                          transition: Transition.rightToLeft,
                                          duration:
                                              const Duration(milliseconds: 400),
                                        );
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.see_all,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: HexColor(
                                                  AppTheme.primaryColorString!),
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              homeController.loadingTransactions.value
                                  ? const ShimmerListView()
                                  : homeController.txnsFetchingFailed.value
                                      ? Text(
                                          'failed getting Transactions',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                        )
                                      : homeController.walletsList.isNotEmpty &&
                                              homeController
                                                  .walletsList[homeController
                                                      .walletIndex.value]
                                                  .transactionList
                                                  .isNotEmpty
                                          ? ListView.separated(
                                              shrinkWrap: true,
                                              primary: false,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(
                                                height: 10,
                                              ),
                                              itemCount: (homeController
                                                          .walletsList[
                                                              homeController
                                                                  .walletIndex
                                                                  .value]
                                                          .transactionList
                                                          .length /
                                                      2)
                                                  .ceil(),
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              itemBuilder: (context, index) =>
                                                  GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                    () => TransactionDetails(
                                                      txnId: homeController
                                                          .walletsList[
                                                              homeController
                                                                  .walletIndex
                                                                  .value]
                                                          .transactionList[
                                                              index]
                                                          .id
                                                          .toString(),
                                                    ),
                                                    transition:
                                                        Transition.downToUp,
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                  );
                                                },
                                                child: TransactionList(
                                                  image: homeController
                                                      .walletsList[
                                                          homeController
                                                              .walletIndex
                                                              .value]
                                                      .transactionList[index]
                                                      .image,
                                                  title: homeController
                                                      .walletsList[
                                                          homeController
                                                              .walletIndex
                                                              .value]
                                                      .transactionList[index]
                                                      .sender
                                                      .fullName,
                                                  subTitle: homeController
                                                      .walletsList[
                                                          homeController
                                                              .walletIndex
                                                              .value]
                                                      .transactionList[index]
                                                      .recipient
                                                      .fullName,
                                                  price: homeController
                                                      .walletsList[
                                                          homeController
                                                              .walletIndex
                                                              .value]
                                                      .transactionList[index]
                                                      .amount,
                                                  time: homeController
                                                      .walletsList[
                                                          homeController
                                                              .walletIndex
                                                              .value]
                                                      .transactionList[index]
                                                      .creationDate,
                                                ),
                                              ),
                                            )
                                          : Column(
                                              children: [
                                                Lottie.asset(
                                                  height: 100,
                                                  DefaultImages.noTrxns,
                                                ),
                                                homeController
                                                        .walletsList.isEmpty
                                                    ? Text(
                                                        'No Transactions Available',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      )
                                                    : Text(
                                                        'No Transactions done yet by this wallet',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                              ],
                                            ),
                            ],
                          ),
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

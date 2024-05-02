import 'package:auto_size_text/auto_size_text.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/style/textstyle.dart';
import '../../../../../core/utils/globales.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/no_data_screen.dart';
import '../../../../../widgets/shimmer_list_view.dart';
import '../../../transfere/transfer_dialog.dart';
import 'edit_member_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'transfere_member_dialog.dart';

class MembersBookScreen extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  MembersBookScreen({super.key, required});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppTheme.isLightTheme == false ? HexColor('#15141f') : Colors.white,
      appBar: AppBar(
        foregroundColor: AppTheme.isLightTheme ? Colors.black : Colors.white,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.members_book_list,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                backgroundColor: AppTheme.isLightTheme == false
                    ? const Color(0xff211F32)
                    : Colors.white,
                clipBehavior: Clip.none,
                ignoreSafeArea: false,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                const EditMemberScreen(),
              );
            },
            icon: const Icon(
              Icons.person_add_alt,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return homeController.getBookingList();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx(
              () => homeController.loadingBookingList.value
                  ? const ShimmerListView(
                      length: 10,
                    )
                  : homeController.membersBook.isEmpty
                      ? Center(
                          child: NoDataScreen(
                            onRefresh: () {
                              homeController.getBookingList();
                            },
                            title:
                                AppLocalizations.of(context)!.no_members_found,
                          ),
                        )
                      : homeController.err.value.isNotEmpty
                          ? Center(
                              child: NoDataScreen(
                                onRefresh: () {
                                  homeController.getBookingList();
                                },
                                title: homeController.err.value,
                              ),
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                ListView.separated(
                                  itemCount: homeController.membersBook.length,
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color:
                                                AppTheme.isLightTheme == false
                                                    ? const Color(0xff211F32)
                                                    : HexColor(AppTheme
                                                        .primaryColorString!),
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          child: ListTile(
                                            title: Row(
                                              children: [
                                                Text(
                                                  '${AppLocalizations.of(context)!.user_name}:',
                                                  style: Theme.of(Get.context!)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                      ),
                                                ),
                                                const SizedBox(width: 10),
                                                AutoSizeText(
                                                  minFontSize: 5,
                                                  maxLines: 2,
                                                  homeController
                                                      .membersBook[index]
                                                      .memberUsername,
                                                  style: Theme.of(Get.context!)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 15.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${AppLocalizations.of(context)!.nickname}:',
                                                        style: Theme.of(
                                                                Get.context!)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                          minFontSize: 5,
                                                          maxLines: 2,
                                                          homeController
                                                              .membersBook[
                                                                  index]
                                                              .memberNickname,
                                                          style: Theme.of(
                                                                  Get.context!)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          homeController
                                                              .pickedWalletId
                                                              .value = 0;

                                                          homeController
                                                              .pickedWalletCurrency
                                                              .value = '';
                                                          homeController
                                                              .pickedWalletName
                                                              .value = '';
                                                          final amountController =
                                                              TextEditingController();
                                                          final GlobalKey<
                                                                  FormState>
                                                              key = GlobalKey<
                                                                  FormState>();
                                                          Get.defaultDialog(
                                                            titlePadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            title:
                                                                '${AppLocalizations.of(context)!.transfere_to} ${homeController.membersBook[index].memberUsername}',
                                                            titleStyle: Theme
                                                                    .of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                            content:
                                                                TransfereMemberDialog(
                                                              amountController:
                                                                  amountController,
                                                              form: key,
                                                              controller:
                                                                  homeController,
                                                              username:
                                                                homeController.membersBook[index].memberUsername,
                                                            ),
                                                            textConfirm:
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .send,
                                                            onConfirm: () {
                                                              if (key.currentState!
                                                                      .validate() &&
                                                                  homeController
                                                                      .pickedWalletName
                                                                      .isNotEmpty) {
                                                                Get.bottomSheet(
                                                                  transferDialog(
                                                                    walletId: homeController
                                                                        .pickedWalletId
                                                                        .value
                                                                        .toString(),
                                                                    homeController:
                                                                        homeController,
                                                                    context:
                                                                        context,
                                                                    amountCurrency:
                                                                        homeController
                                                                            .pickedWalletCurrency
                                                                            .value,
                                                                    amount:
                                                                        amountController
                                                                            .text,
                                                                    recipient: homeController
                                                                        .membersBook[
                                                                            index]
                                                                        .memberUsername,
                                                                    wallet: homeController
                                                                        .pickedWalletName
                                                                        .value,
                                                                    type:
                                                                        'username',
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            buttonColor: AppTheme
                                                                    .isLightTheme
                                                                ? HexColor(
                                                                    AppTheme
                                                                        .primaryColorString!,
                                                                  )
                                                                : Colors.white,
                                                            confirmTextColor:
                                                                AppTheme.isLightTheme
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                          );
                                                        },
                                                        child: customButton(
                                                          HexColor(
                                                            AppTheme
                                                                .secondaryColorString!,
                                                          ),
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .send,
                                                          Colors.black,
                                                          context,
                                                          width: 70,
                                                          height: 35,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        '#${homeController.membersBook[index].id}',
                                                        style: Theme.of(
                                                                Get.context!)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -10,
                                          right: language == 'ar' ? null : -7,
                                          left: language == 'ar' ? -7 : null,
                                          child: PopupMenuButton(
                                            onSelected: (value) {
                                              if (value == 0) {
                                                Get.bottomSheet(
                                                  backgroundColor: AppTheme
                                                              .isLightTheme ==
                                                          false
                                                      ? const Color(0xff211F32)
                                                      : Colors.white,
                                                  clipBehavior: Clip.none,
                                                  ignoreSafeArea: false,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(25),
                                                      topRight:
                                                          Radius.circular(25),
                                                    ),
                                                  ),
                                                  EditMemberScreen(
                                                    edit: true,
                                                    memberId: homeController
                                                        .membersBook[index]
                                                        .memberId
                                                        .toString(),
                                                    memberName: homeController
                                                        .membersBook[index]
                                                        .memberUsername,
                                                    memberNickname:
                                                        homeController
                                                            .membersBook[index]
                                                            .memberNickname,
                                                  ),
                                                );
                                              } else {
                                                Get.defaultDialog(
                                                  title: AppLocalizations.of(context)!.confirm,
                                                  middleText:
                                                      AppLocalizations.of(context)!.delete_member_msg,
                                                  cancel: GestureDetector(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: customButton(
                                                      Colors.red,
                                                      AppLocalizations.of(context)!.cancel,
                                                      HexColor(AppTheme
                                                          .secondaryColorString!),
                                                      context,
                                                      width: 100,
                                                      height: 40,
                                                    ),
                                                  ),
                                                  confirm: GestureDetector(
                                                    onTap: () {
                                                      Get.back();
                                                      homeController
                                                          .deleteFromBookingList(
                                                        memberId: homeController
                                                            .membersBook[index]
                                                            .memberId
                                                            .toString(),
                                                        context: context,
                                                      );
                                                    },
                                                    child: customButton(
                                                      HexColor(
                                                        AppTheme
                                                            .primaryColorString!,
                                                      ),
                                                    AppLocalizations.of(context)!.yes,
                                                      HexColor(
                                                        AppTheme
                                                            .secondaryColorString!,
                                                      ),
                                                      context,
                                                      width: 100,
                                                      height: 40,
                                                    ),
                                                  ),
                                                  confirmTextColor: HexColor(
                                                    AppTheme
                                                        .primaryColorString!,
                                                  ),
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
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.edit_outlined,
                                                        color: Colors.green,
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .edit,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: 1,
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .delete_outline_rounded,
                                                        color: Colors.red,
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .delete,
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
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 15,
                                  ),
                                ),
                                homeController.loadingDeleteBookingList.value
                                    ? const IndicatorBlurLoading()
                                    : const SizedBox(),
                              ],
                            ),
            ),
          ),
        ),
      ),
    );
  }
}

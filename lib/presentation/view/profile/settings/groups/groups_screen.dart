// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:finpay/widgets/no_data_screen.dart';
import 'package:finpay/widgets/shimmer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/globales.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../transfere/transfer_dialog.dart';
import 'edit_group_screen.dart';
import 'group_members_screen.dart';
import 'transfere_group_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupsScreen extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppTheme.isLightTheme == false ? HexColor('#15141f') : Colors.white,
      appBar: AppBar(
        foregroundColor: AppTheme.isLightTheme ? Colors.black : Colors.white,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.my_groups,
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
                const EditGroupScreen(),
              );
            },
            icon: const Icon(
              Icons.group_add_outlined,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return homeController.getGroups(context: context);
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx(
              () => homeController.loadingGroups.value
                  ? const ShimmerListView(
                      length: 10,
                    )
                  : homeController.groups.isEmpty
                      ? Center(
                          child: NoDataScreen(
                            onRefresh: () {
                              homeController.getGroups(context: context);
                            },
                            title: 'No Groups Added Yet',
                          ),
                        )
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            ListView.separated(
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    homeController.groupMembers.value = [];
                                    homeController.getGroupMembers(
                                      context: context,
                                      groupId: homeController.groups[index].id
                                          .toString(),
                                    );
                                    Get.to(
                                      () => GroupMembersScreen(
                                        homeController: homeController,
                                        group: homeController.groups[index],
                                      ),
                                      transition: Transition.downToUp,
                                      duration:
                                          const Duration(milliseconds: 500),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: AppTheme.isLightTheme == false
                                              ? const Color(0xff211F32)
                                              : HexColor(
                                                  AppTheme.primaryColorString!),
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: ListTile(
                                          title: Row(
                                            children: [
                                              Text(
                                                homeController
                                                    .groups[index].name,
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
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Flexible(
                                                child: FittedBox(
                                                  child: Text(
                                                    'Created At: ${homeController.groups[index].creationDate}, ${homeController.groups[index].creationTime} ',
                                                    style:
                                                        Theme.of(Get.context!)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              AutoSizeText(
                                                maxLines: 3,
                                                homeController
                                                    .groups[index].about,
                                                style: Theme.of(Get.context!)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  homeController
                                                      .pickedWalletId.value = 0;

                                                  homeController
                                                      .pickedWalletCurrency
                                                      .value = '';
                                                  homeController
                                                      .pickedWalletName
                                                      .value = '';
                                                  final amountController =
                                                      TextEditingController();
                                                  final GlobalKey<FormState>
                                                      key =
                                                      GlobalKey<FormState>();
                                                  Get.defaultDialog(
                                                    titlePadding:
                                                        const EdgeInsets.all(
                                                      20,
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                      20,
                                                    ),
                                                    title:
                                                        '${AppLocalizations.of(context)!.transfere_to} ${homeController.groups[index].name}',
                                                    titleStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                    content:
                                                        TransfereGroupDialog(
                                                      amountController:
                                                          amountController,
                                                      form: key,
                                                      controller:
                                                          homeController,
                                                      groupName: homeController
                                                          .groups[index].name,
                                                      groupId: homeController
                                                          .groups[index].id
                                                          .toString(),
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
                                                            groupId:
                                                                homeController
                                                                    .groups[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                            walletId:
                                                                homeController
                                                                    .pickedWalletId
                                                                    .value
                                                                    .toString(),
                                                            homeController:
                                                                homeController,
                                                            context: context,
                                                            amountCurrency:
                                                                homeController
                                                                    .pickedWalletCurrency
                                                                    .value,
                                                            amount:
                                                                amountController
                                                                    .text,
                                                            recipient:
                                                                homeController
                                                                    .groups[
                                                                        index]
                                                                    .name,
                                                            wallet: homeController
                                                                .pickedWalletName
                                                                .value,
                                                            type: 'group',
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    buttonColor:
                                                        AppTheme.isLightTheme
                                                            ? HexColor(
                                                                AppTheme
                                                                    .primaryColorString!,
                                                              )
                                                            : Colors.white,
                                                    confirmTextColor:
                                                        AppTheme.isLightTheme
                                                            ? Colors.white
                                                            : Colors.black,
                                                  );
                                                },
                                                child: customButton(
                                                  HexColor(AppTheme
                                                      .secondaryColorString!),
                                                  AppLocalizations.of(context)!
                                                      .send,
                                                  Colors.black,
                                                  context,
                                                  width: 70,
                                                  height: 35,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        right: language == 'ar' ? null : 10,
                                        left: language == 'ar' ? 10 : null,
                                        child: Text(
                                          '${AppLocalizations.of(context)!.members}: ${homeController.groups[index].membersCount}',
                                          style: Theme.of(Get.context!)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
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
                                                EditGroupScreen(
                                                  edit: true,
                                                  groupId: homeController
                                                      .groups[index].id
                                                      .toString(),
                                                  groupName: homeController
                                                      .groups[index].name,
                                                  groupAbout: homeController
                                                      .groups[index].about,
                                                ),
                                              );
                                            } else {
                                              Get.defaultDialog(
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .confirm,
                                                middleText:
                                                    AppLocalizations.of(context)!.delete_group_msg,
                                                cancel: GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: customButton(
                                                    Colors.red,
                                                    AppLocalizations.of(
                                                            context)!
                                                        .cancel,
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
                                                    homeController.deleteGroup(
                                                      groupId: homeController
                                                          .groups[index].id
                                                          .toString(),
                                                      context: context,
                                                    );
                                                  },
                                                  child: customButton(
                                                    HexColor(
                                                      AppTheme
                                                          .primaryColorString!,
                                                    ),
                                                    AppLocalizations.of(
                                                            context)!
                                                        .yes,
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
                                                  AppTheme.primaryColorString!,
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
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount: homeController.groups.length,
                            ),
                            homeController.loadingEditGroup.value
                                ? const IndicatorBlurLoading()
                                : const SizedBox()
                          ],
                        ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/presentation/controller/services_controller.dart';
import 'package:finpay/presentation/view/home/widget/trader_list.dart';
import 'package:finpay/widgets/no_data_screen.dart';
import 'package:finpay/widgets/shimmer_list_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_button.dart';
import '../../controller/home_controller.dart';
import 'add_Service_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServicesDashBoard extends StatefulWidget {
  final ServicesController servicesController;
  const ServicesDashBoard({super.key, required this.servicesController});

  @override
  State<ServicesDashBoard> createState() => _ServicesDashBoardState();
}

class _ServicesDashBoardState extends State<ServicesDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.servicesController.pickedField = '';
          Get.find<HomeController>().pickedWalletCurrency.value = '';
          Get.find<HomeController>().pickedWalletName.value = '';

          Get.to(
            () => const AddServiceScreen(),
            duration: const Duration(milliseconds: 500),
            transition: Transition.downToUp,
          );
        },
        shape: const CircleBorder(),
        backgroundColor: HexColor(AppTheme.primaryColorString!),
        child: const Icon(
          Icons.add,
        ),
      ),
      backgroundColor: AppTheme.isLightTheme == false
          ? const Color(0xff15141F)
          : Colors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.my_services,
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
          () => widget.servicesController.loading.value
              ? const ShimmerListView(
                  length: 10,
                )
              : widget.servicesController.services.value!.provider.myServices
                      .isEmpty
                  ? Center(
                      child: NoDataScreen(
                        onRefresh: () {
                          widget.servicesController.getServices(context);
                        },
                        title: AppLocalizations.of(context)!.no_services,
                      ),
                    )
                  : Stack(
                      children: [
                        ListView.separated(
                          padding: const EdgeInsets.all(15.0),
                          itemBuilder: (context, index) => Stack(
                            alignment: Alignment.topRight,
                            children: [
                              TraderList(
                                color: AppTheme.isLightTheme == false
                                    ? const Color(0xff211F32)
                                    : HexColor(AppTheme.primaryColorString!)
                                        .withOpacity(0.9),
                                title: widget.servicesController.services.value!
                                    .provider.myServices[index].name,
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget
                                          .servicesController
                                          .services
                                          .value!
                                          .provider
                                          .myServices[index]
                                          .description,
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '${AppLocalizations.of(context)!.city} :',
                                          style: Theme.of(Get.context!)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                        ),
                                        Text(
                                          widget
                                              .servicesController
                                              .services
                                              .value!
                                              .provider
                                              .myServices[index]
                                              .city,
                                          style: Theme.of(Get.context!)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                price:
                                    ' ${widget.servicesController.services.value!.provider.myServices[index].amount} ${widget.servicesController.services.value!.provider.myServices[index].walletCurrency}',
                                time: widget.servicesController.services.value!
                                    .provider.myServices[index].creationTime,
                              ),
                              Positioned(
                                top: -10,
                                right: -7,
                                child: PopupMenuButton(
                                  onSelected: (value) {
                                    if (value == 0) {
                                      Get.defaultDialog(
                                        title: 'Confirm',
                                        middleText: widget
                                                .servicesController
                                                .services
                                                .value!
                                                .provider
                                                .myServices[index]
                                                .active
                                            ? 'Are you sure you want to deactivate this Service?'
                                            : 'Are you sure you want to activate this Service?',
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
                                            widget.servicesController
                                                .toggleService(
                                              context: context,
                                              serviceId: widget
                                                  .servicesController
                                                  .services
                                                  .value!
                                                  .provider
                                                  .myServices[index]
                                                  .id
                                                  .toString(),
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
                                    } else {
                                      Get.defaultDialog(
                                        title: 'Confirm',
                                        middleText:
                                            'Are you sure you want to delete this Service?',
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

                                            widget.servicesController
                                                .deleteService(
                                              context: context,
                                              serviceId: widget
                                                  .servicesController
                                                  .services
                                                  .value!
                                                  .provider
                                                  .myServices[index]
                                                  .id
                                                  .toString(),
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
                                          widget
                                                  .servicesController
                                                  .services
                                                  .value!
                                                  .provider
                                                  .myServices[index]
                                                  .active
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
                              Positioned(
                                bottom: 3,
                                right: language=='ar'?null: 15,
                                left: language=='ar'?15:null,
                                child: Text(
                                  widget.servicesController.services.value!
                                          .provider.myServices[index].active
                                      ? AppLocalizations.of(context)!.activated
                                      : AppLocalizations.of(context)!.deactivated,
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: widget
                                                .servicesController
                                                .services
                                                .value!
                                                .provider
                                                .myServices[index]
                                                .active
                                            ? Colors.greenAccent
                                            : Colors.red,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                          itemCount: widget.servicesController.services.value!
                              .provider.myServices.length,
                        ),
                        widget.servicesController.loadingServiceEdit.value
                            ? BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 2,
                                  sigmaY: 2,
                                ),
                                child: const SizedBox(),
                              )
                            : const SizedBox()
                      ],
                    ),
        ),
      ),
    );
  }
}

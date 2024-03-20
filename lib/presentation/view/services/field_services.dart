// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:finpay/presentation/controller/services_controller.dart';
import 'package:finpay/presentation/view/home/widget/trader_list.dart';
import 'package:finpay/widgets/shimmer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/style/textstyle.dart';
import '../../../widgets/no_data_screen.dart';
import 'service_details_screen.dart';

class FieldServices extends StatelessWidget {
  final String fieldId, name;
  FieldServices({
    super.key,
    required this.fieldId,
    required this.name,
  });

  final servicesController = Get.find<ServicesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.isLightTheme == false
          ? const Color(0xff15141F)
          : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.isLightTheme ? Colors.black : Colors.white,
        title: AutoSizeText(
          '$name Services',
          maxLines: 2,
          style: Theme.of(Get.context!).textTheme.caption!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return servicesController.getFieldServices(
            context: context,
            fieldId: fieldId,
          );
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx(
              () => servicesController.loadingFieldServices.value
                  ? const ShimmerListView(
                      length: 10,
                    )
                  : servicesController.servicesDetails.isEmpty
                      ? Center(
                          child: NoDataScreen(
                              title: 'No Available Services',
                              onRefresh: () {
                                servicesController.getFieldServices(
                                  context: context,
                                  fieldId: fieldId,
                                );
                              }),
                        )
                      : Stack(
                          children: [
                            ListView.separated(
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    servicesController.getServiceDetails(
                                      context: context,
                                      serviceId: servicesController
                                          .servicesDetails[index].id
                                          .toString(),
                                    );
                                    Get.to(
                                      () => ServiceDetailsScreen(
                                        serviceController: servicesController,
                                      ),
                                      duration: const Duration(
                                        milliseconds: 450,
                                      ),
                                      transition: Transition.downToUp,
                                    );
                                  },
                                  child: TraderList(
                                    color: AppTheme.isLightTheme == false
                                        ? const Color(0xff211F32)
                                        : HexColor(AppTheme.primaryColorString!)
                                            .withOpacity(0.9),
                                    title: servicesController
                                        .servicesDetails[index].name,
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          servicesController
                                              .servicesDetails[index]
                                              .description,
                                          style: Theme.of(Get.context!)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'City :',
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
                                              servicesController
                                                  .servicesDetails[index].city,
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
                                        ' ${servicesController.servicesDetails[index].amount} ${servicesController.servicesDetails[index].walletCurrency}',
                                    time: servicesController
                                        .servicesDetails[index].creationTime,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount:
                                  servicesController.servicesDetails.length,
                            ),
                            servicesController.loadingServiceDetails.value
                                ? BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 2,
                                      sigmaY: 2,
                                    ),
                                    child: const SizedBox(),
                                  )
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

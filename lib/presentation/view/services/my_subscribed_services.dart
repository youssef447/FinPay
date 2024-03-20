// ignore_for_file: deprecated_member_use


import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/presentation/controller/services_controller.dart';
import 'package:finpay/presentation/view/home/widget/trader_list.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:finpay/widgets/shimmer_list_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_button.dart';

class MySubscribedServices extends StatefulWidget {
  final ServicesController servicesController;
  const MySubscribedServices({super.key, required this.servicesController});

  @override
  State<MySubscribedServices> createState() => _MySubscribedServicesState();
}

class _MySubscribedServicesState extends State<MySubscribedServices> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => widget.servicesController.loading.value
          ? const ShimmerListView(
              length: 10,
            )
          : widget.servicesController.services.value!.mySubscribedServices
                  .isEmpty
              ?Center(
                  child: Text(
                    'No subscribed services yet',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                )
              : ListView.separated(
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
                            .mySubscribedServices[index].name,
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.servicesController.services.value!
                                  .mySubscribedServices[index].description,
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
                                  widget.servicesController.services.value!
                                      .mySubscribedServices[index].city,
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
                            ' ${widget.servicesController.services.value!.mySubscribedServices[index].amount} ${widget.servicesController.services.value!.mySubscribedServices[index].walletCurrency}',
                        time: widget.servicesController.services.value!
                            .mySubscribedServices[index].creationTime,
                      ),
                      widget.servicesController.loadingServiceEdit.value
                          ? const IndicatorBlurLoading()
                          : Positioned(
                              bottom: 10,
                              right: language == 'ar' ? null : 15,
                              left: language == 'ar' ? 15 : null,
                              child: GestureDetector(
                                onTap: () {
                                  widget.servicesController.unsubscribe(
                                    context: context,
                                    serviceId: widget
                                        .servicesController
                                        .services
                                        .value!
                                        .mySubscribedServices[index]
                                        .id
                                        .toString(),
                                  );
                                },
                                child: customButton(Colors.red, AppLocalizations.of(context)!.unsubscribe,
                                    Colors.white, context,
                                    width: 100, fontSize: 13, height: 35),
                              ),
                            ),
                    ],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  itemCount: widget.servicesController.services.value!
                      .mySubscribedServices.length,
                ),
    );
  }
}

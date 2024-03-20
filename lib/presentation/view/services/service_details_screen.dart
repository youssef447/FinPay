// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finpay/core/animations/horizontal_fade_transition.dart';
import 'package:finpay/presentation/controller/services_controller.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:finpay/widgets/shimmer_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/style/textstyle.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/default_cached_image.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final ServicesController serviceController;

  const ServiceDetailsScreen({
    super.key,
    required this.serviceController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor:
            AppTheme.isLightTheme == false ? Colors.white : Colors.black,
        title: Text(
          AppLocalizations.of(context)!.service_details,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(),
        ),
      ),
      backgroundColor: AppTheme.isLightTheme == false
          ? const Color(0xff323045)
          : Theme.of(context).canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.05,
              ),
              Obx(
                () => serviceController.loadingServiceDetails.value
                    ? const Center(child: ShimmerDetails())
                    : HorizontalFadeTransition(
                        delayed: true,
                        child: Container(
                          width: Get.width * 0.9,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppTheme.isLightTheme == false
                                ? const Color(0xff211F32)
                                : HexColor(AppTheme.primaryColorString!)
                                    .withOpacity(0.7),
                          ),
                          child: serviceController.detailsErrMessage.isNotEmpty
                              ? Center(
                                  child: Text(
                                    serviceController.detailsErrMessage.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .color,
                                        ),
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      radius: 32,
                                      backgroundColor:
                                          HexColor(AppTheme.primaryColorString!)
                                              .withOpacity(0.5),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 26,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(26),
                                          child: DefaultCachedImage(
                                            imgUrl: serviceController
                                                .serviceDetailsModel
                                                .value!
                                                .image,
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      serviceController
                                          .serviceDetailsModel.value!.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                    ),
                                    const SizedBox(height: 20),
                                    AutoSizeText(
                                      serviceController.serviceDetailsModel
                                          .value!.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                    ),
                                    const SizedBox(height: 25),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .price,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                            Text(
                                              '${serviceController.serviceDetailsModel.value!.amount} ${serviceController.serviceDetailsModel.value!.walletCurrency}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Divider(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .color!
                                              .withOpacity(0.08),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .field___,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                            Flexible(
                                              child: AutoSizeText(
                                                maxLines: 2,
                                                serviceController
                                                    .serviceDetailsModel
                                                    .value!
                                                    .fieldName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Divider(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .color!
                                              .withOpacity(0.08),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .city,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                            AutoSizeText(
                                              maxLines: 2,
                                              serviceController
                                                  .serviceDetailsModel
                                                  .value!
                                                  .city,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Divider(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .color!
                                              .withOpacity(0.08),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .address,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                            Flexible(
                                              child: AutoSizeText(
                                                maxLines: 2,
                                                serviceController
                                                    .serviceDetailsModel
                                                    .value!
                                                    .address,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Divider(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .color!
                                              .withOpacity(0.08),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .date,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                            Text(
                                              serviceController
                                                  .serviceDetailsModel
                                                  .value!
                                                  .creationTime,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Divider(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .color!
                                              .withOpacity(0.08),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .provider___,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                            Flexible(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 15,
                                                    backgroundImage:
                                                        CachedNetworkImageProvider(
                                                      serviceController
                                                          .serviceDetailsModel
                                                          .value!
                                                          .provider!
                                                          .providerImg,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  AutoSizeText(
                                                    serviceController
                                                        .serviceDetailsModel
                                                        .value!
                                                        .provider!
                                                        .providrname,
                                                    maxLines: 2,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Divider(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .color!
                                              .withOpacity(0.08),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .phone_,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                            Text(
                                              serviceController
                                                      .serviceDetailsModel
                                                      .value!
                                                      .provider!
                                                      .phone ??
                                                  'N/A',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                      ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Obx(
                () => serviceController.detailsErrMessage.isNotEmpty ||
                        serviceController.loadingServiceDetails.value
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          serviceController.loadingSubscribtion.value
                              ? const IndicatorBlurLoading()
                              : GestureDetector(
                                  onTap: () {
                                    serviceController.serviceDetailsModel.value!
                                            .subscribed
                                        ? serviceController.unsubscribe(
                                            serviceId: serviceController
                                                .serviceDetailsModel.value!.id
                                                .toString(),
                                            context: context,
                                          )
                                        : serviceController.subscribe(
                                            serviceId: serviceController
                                                .serviceDetailsModel.value!.id
                                                .toString(),
                                            context: context,
                                          );
                                  },
                                  child: customButton(
                                    serviceController.serviceDetailsModel.value!
                                            .subscribed
                                        ? Colors.red
                                        : Colors.yellow,
                                    serviceController.serviceDetailsModel.value!
                                            .subscribed
                                        ? AppLocalizations.of(context)!
                                            .unsubscribe
                                            .toLowerCase()
                                        : AppLocalizations.of(context)!
                                            .subscribe
                                            .toLowerCase(),
                                    serviceController.serviceDetailsModel.value!
                                            .subscribed
                                        ? Colors.white
                                        : Colors.black54,
                                    context,
                                    width: Get.width / 2.8,
                                    height: 40,
                                  ),
                                ),
                          serviceController.loadingPay.value
                              ? const IndicatorBlurLoading()
                              : GestureDetector(
                                  onTap: () {
                                    serviceController.payService(
                                      context: context,
                                      serviceId: serviceController
                                          .serviceDetailsModel.value!.id
                                          .toString(),
                                    );
                                  },
                                  child: customButton(
                                    HexColor(AppTheme.primaryColorString!),
                                    AppLocalizations.of(context)!.pay,
                                    Colors.white,
                                    context,
                                    width: Get.width / 2.8,
                                    height: 40,
                                  ),
                                ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

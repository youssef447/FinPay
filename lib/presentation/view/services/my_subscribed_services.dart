// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:finpay/presentation/controller/services_controller.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:finpay/widgets/no_data_screen.dart';
import 'package:finpay/widgets/shimmer_list_view.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/style/textstyle.dart';
import '../../../widgets/default_cached_image.dart';
import 'service_details_screen.dart';

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
          : 
           widget.servicesController.services.value==null||widget.servicesController.services.value!.mySubscribedServices
                  .isEmpty
              ? Center(
                  child: NoDataScreen(
                    title: AppLocalizations.of(context)!.no_sub,
                    onRefresh: () {
                      widget.servicesController.getServices(context);
                    },
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(15.0),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      widget.servicesController.getServiceDetails(
                        context: context,
                        serviceId: widget.servicesController.services.value!
                            .mySubscribedServices[index].id
                            .toString(),
                      );
                      Get.to(
                        () => ServiceDetailsScreen(
                          serviceController: widget.servicesController,
                        ),
                        duration: const Duration(
                          milliseconds: 450,
                        ),
                        transition: Transition.downToUp,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(11.0),
                      decoration: BoxDecoration(
                        color: AppTheme.isLightTheme == false
                            ? const Color(0xff211F32)
                            : HexColor(
                                AppTheme.primaryColorString!,
                              ).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor:
                                HexColor(AppTheme.primaryColorString!)
                                    .withOpacity(0.5),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 26,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(26),
                                child: DefaultCachedImage(
                                  imgUrl:
                                      'https://paytome.net/apis/images/traders/no_image.png',
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  maxLines: 2,
                                  widget.servicesController.services.value!
                                      .mySubscribedServices[index].name,
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.servicesController.services.value!
                                      .mySubscribedServices[index].description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontSize: 11,
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
                                          .titleLarge!
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
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  ' ${widget.servicesController.services.value!.mySubscribedServices[index].amount} ${widget.servicesController.services.value!.mySubscribedServices[index].walletCurrency}',
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                ),
                                Text(
                                  maxLines: 1,
                                  widget.servicesController.services.value!
                                      .mySubscribedServices[index].creationTime,
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Obx(
                                  () => widget.servicesController
                                          .loadingSubscribtion.value
                                      ? const IndicatorBlurLoading()
                                      : SizedBox(
                                          height: 30,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                              ),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                Colors.red,
                                              ),
                                            ),
                                            onPressed: () {
                                              widget.servicesController
                                                  .unsubscribe(
                                                context: context,
                                                serviceId: widget
                                                    .servicesController
                                                    .services
                                                    .value!
                                                    .mySubscribedServices[index]
                                                    .id
                                                    .toString(),
                                                mySubs: true,
                                              );
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .unsubscribe
                                                  .toLowerCase(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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

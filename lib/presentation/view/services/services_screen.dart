// ignore_for_file: deprecated_member_use

import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/presentation/controller/services_controller.dart';
import 'package:finpay/presentation/view/services/my_subscribed_services.dart';
import 'package:finpay/widgets/no_data_screen.dart';
import 'package:finpay/widgets/shimmer_list_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/custom_button.dart';
import 'be_provider_screen.dart';
import 'dashboard.dart';
import 'field_services.dart';

class ServiceScreen extends StatefulWidget {
  final ServicesController servicesController;
  const ServiceScreen({Key? key, required this.servicesController}) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () {
          return  widget.servicesController.getServices(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            alignment:
                language == 'ar' ? Alignment.bottomLeft : Alignment.bottomRight,
            children: [
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.services,
                    style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
                          letterSpacing: 2,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(
                    height: AppBar().preferredSize.height,
                  ),
                  /* SvgPicture.asset(
                    'assets/images/services.svg',
                    height: 85,
                  
                  ),
                  const SizedBox(
                    height: 40,
                  ), */
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                             widget.servicesController.currentIndex.value = 0;
                          },
                          child: customButton(
                               widget.servicesController.currentIndex.value == 0
                                  ? HexColor(AppTheme.primaryColorString!)
                                  : Colors.white,
                              AppLocalizations.of(context)!.all_fields,
                               widget.servicesController.currentIndex.value == 0
                                  ? Colors.white
                                  : Colors.black,
                              context,
                              width: Get.width * 0.35,
                              height: 40,
                              fontSize: 13),
                        ),
                        GestureDetector(
                          onTap: () {
                             widget.servicesController.currentIndex.value = 1;
                          },
                          child: customButton(
                             widget.servicesController.currentIndex.value == 1
                                ? HexColor(AppTheme.primaryColorString!)
                                : Colors.white,
                            AppLocalizations.of(context)!.subscribed_services,
                             widget.servicesController.currentIndex.value == 1
                                ? Colors.white
                                : Colors.black,
                            context,
                            width: Get.width * 0.45,
                            height: 40,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => Expanded(
                      child:  widget.servicesController.currentIndex.value == 0
                          ?  widget.servicesController.loading.value
                              ? const ShimmerListView(length: 10)
                              :  widget.servicesController.services.value==null||  widget.servicesController.services.value!.fields.isEmpty
                                  ? Center(
                                      child: NoDataScreen(
                                          title: AppLocalizations.of(context)!.no_services,
                                          onRefresh: () {
                                             widget.servicesController
                                                .getServices(context);
                                          }),
                                    )
                                  : ListView.separated(
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                            onTap: () {
                                               widget.servicesController
                                                  .getFieldServices(
                                                fieldId:  widget.servicesController
                                                    .services
                                                    .value!
                                                    .fields[index]
                                                    .fieldId
                                                    .toString(),
                                                context: context,
                                              );
                                              Get.to(
                                                () => FieldServices(
                                                  fieldId:  widget.servicesController
                                                      .services
                                                      .value!
                                                      .fields[index]
                                                      .fieldId
                                                      .toString(),
                                                  name:  widget.servicesController
                                                      .services
                                                      .value!
                                                      .fields[index]
                                                      .fieldName,
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              decoration: BoxDecoration(
                                                color: AppTheme.isLightTheme ==
                                                        false
                                                    ? const Color(0xff211F32)
                                                    : Colors.grey.withOpacity(
                                                        0.1,
                                                      ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  15,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                     widget.servicesController
                                                        .services
                                                        .value!
                                                        .fields[index]
                                                        .fieldName,
                                                    style:
                                                        Theme.of(Get.context!)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                  ),
                                                  const Icon(
                                                    Icons.arrow_forward_ios,
                                                  ),
                                                ],
                                              ),
                                            ));
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: 10,
                                      ),
                                      itemCount:  widget.servicesController
                                          .services.value!.fields.length,
                                    )
                          : MySubscribedServices(
                              servicesController:  widget.servicesController,
                            ),
                    ),
                  ),
                ],
              ),
              Obx(
                () =>  widget.servicesController.loading.value|| widget.servicesController.services.value==null
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () {
                           widget.servicesController.services.value!.isProvider == null
                              ? Get.to(
                                  () => ServicesDashBoard(
                                    servicesController:  widget.servicesController,
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                  transition: Transition.downToUp,
                                )
                              : Get.to(
                                  () => const BeProviderScreen(),
                                  duration: const Duration(milliseconds: 500),
                                  transition: Transition.downToUp,
                                );
                        },
                        child: customButton(
                          HexColor(AppTheme.primaryColorString!),
                           widget.servicesController.services.value!.isProvider == null
                              ? AppLocalizations.of(context)!.dashboard
                              : AppLocalizations.of(context)!.be_provider,
                          HexColor(AppTheme.secondaryColorString!),
                          context,
                          width: Get.width / 2.7,
                          height: 40,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

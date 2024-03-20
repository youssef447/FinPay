// ignore_for_file: deprecated_member_use

import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/presentation/controller/services_controller.dart';
import 'package:finpay/presentation/view/services/my_subscribed_services.dart';
import 'package:finpay/widgets/no_data_screen.dart';
import 'package:finpay/widgets/shimmer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/custom_button.dart';
import 'be_provider_screen.dart';
import 'dashboard.dart';
import 'field_services.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final serviceController = Get.put(ServicesController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () {
          return serviceController.getServices(context);
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
                    style: Theme.of(Get.context!).textTheme.bodyText2!.copyWith(
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
                            serviceController.currentIndex.value = 0;
                          },
                          child: customButton(
                              serviceController.currentIndex.value == 0
                                  ? HexColor(AppTheme.primaryColorString!)
                                  : Colors.white,
                              AppLocalizations.of(context)!.all_fields,
                              serviceController.currentIndex.value == 0
                                  ? Colors.white
                                  : Colors.black,
                              context,
                              width: Get.width * 0.35,
                              height: 40,
                              fontSize: 13),
                        ),
                        GestureDetector(
                          onTap: () {
                            serviceController.currentIndex.value = 1;
                          },
                          child: customButton(
                            serviceController.currentIndex.value == 1
                                ? HexColor(AppTheme.primaryColorString!)
                                : Colors.white,
                            AppLocalizations.of(context)!.subscribed_services,
                            serviceController.currentIndex.value == 1
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
                      child: serviceController.currentIndex.value == 0
                          ? serviceController.loading.value
                              ? const ShimmerListView(length: 10)
                              : serviceController.services.value!.fields.isEmpty
                                  ? Center(
                                      child: NoDataScreen(
                                          title: 'No Available Services',
                                          onRefresh: () {
                                            serviceController
                                                .getServices(context);
                                          }),
                                    )
                                  : ListView.separated(
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              serviceController
                                                  .getFieldServices(
                                                fieldId: serviceController
                                                    .services
                                                    .value!
                                                    .fields[index]
                                                    .fieldId
                                                    .toString(),
                                                context: context,
                                              );
                                              Get.to(() => FieldServices(
                                                    fieldId: serviceController
                                                        .services
                                                        .value!
                                                        .fields[index]
                                                        .fieldId
                                                        .toString(),
                                                    name: serviceController
                                                        .services
                                                        .value!
                                                        .fields[index]
                                                        .fieldName,
                                                  ));
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
                                                    serviceController
                                                        .services
                                                        .value!
                                                        .fields[index]
                                                        .fieldName,
                                                    style:
                                                        Theme.of(Get.context!)
                                                            .textTheme
                                                            .bodyText2!
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
                                      itemCount: serviceController
                                          .services.value!.fields.length,
                                    )
                          : MySubscribedServices(
                              servicesController: serviceController,
                            ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => serviceController.loading.value
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () {
                          serviceController.services.value!.isProvider == null
                              ? Get.to(
                                  () => ServicesDashBoard(
                                    servicesController: serviceController,
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
                          serviceController.services.value!.isProvider == null
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

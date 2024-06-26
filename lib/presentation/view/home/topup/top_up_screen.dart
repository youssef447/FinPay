// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/top_up_controller.dart';
import 'package:finpay/presentation/view/home/topup/branches.dart';
import 'package:finpay/widgets/custom_button.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class TopUpSCreen extends StatefulWidget {
  final double? latitude, longitude;
  const TopUpSCreen({
    Key? key,
    this.latitude,
    this.longitude,
  }) : super(key: key);

  @override
  State<TopUpSCreen> createState() => _TopUpSCreenState();
}

class _TopUpSCreenState extends State<TopUpSCreen> {
  final controller = Get.put(TopupController());

  late final MapController mapController;
    late final MapOptions mapOptions;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
mapController=MapController();
    controller.getBranches(context: context);
    
    if (widget.latitude != null && widget.longitude != null) {
      mapOptions = MapOptions(
        initialCenter: LatLng(widget.latitude!, widget.longitude!),
        zoom: 15,
      );
      controller.center.value = LatLng(widget.latitude!, widget.longitude!);
    
    }
    else{
      mapOptions = const MapOptions(
    initialCenter: LatLng(33.513805, 36.276527),
    zoom: 15,
  );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.isLightTheme == false
          ? const Color(0xff211F32)
          : HexColor(AppTheme.secondaryColorString!),
      body: SafeArea(
        child: Stack(
          children: [
            Obx(
              () => controller.currentIndex.value == 1
                  ? BranchesTap()
                  : controller.loadingBranches.value
                      ? const Center(
                          child: IndicatorBlurLoading(),
                        )
                      : Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            FlutterMap(
                              
                              mapController:  mapController,
                              options: mapOptions,
                            
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.example.app',
                                ),
                                MarkerLayer(
                                  markers: controller.branches
                                      .map(
                                        (element) => Marker(
                                          point: LatLng(
                                            double.parse(element.lat),
                                            double.parse(element.long),
                                          ),
                                          child: Column(
                                            children: [
                                              const Flexible(
                                                child: Icon(
                                                  Icons.location_pin,
                                                  color: Colors.red,
                                                  size: 18,
                                                ),
                                              ),
                                              Flexible(
                                                child: FittedBox(
                                                  child: Text(
                                                    element.branchName,
                                                    style:
                                                        Theme.of(Get.context!)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                              letterSpacing: 2,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              color: Colors.red,
                                                            ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: CircleAvatar(
                                      backgroundColor: HexColor(
                                        AppTheme.primaryColorString!,
                                      ),
                                      child: const Icon(
                                        Icons.arrow_back_ios_new,
                                      )),
                                ),
                                IconButton(
                                  onPressed: () {
                                    controller.getCurrentLocation(
                                      context: context,
                                      controller:mapController,
                                    );
                                  },
                                  icon: controller.center.value.longitude !=
                                              36.276527 &&
                                          controller.center.value.latitude !=
                                              33.513805
                                      ? Icon(
                                          Icons.my_location_rounded,
                                          size: 50,
                                          color: HexColor(
                                              AppTheme.primaryColorString!),
                                        )
                                      : Icon(
                                          Icons.location_searching_rounded,
                                          size: 50,
                                          color: HexColor(
                                              AppTheme.primaryColorString!),
                                        ),
                                ),
                              ],
                            ),
                            controller.loadingPosition.value
                                ? BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                    child: const SizedBox(),
                                  )
                                : const SizedBox()
                          ],
                        ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.currentIndex.value = 0;
                      },
                      child: customButton(
                        controller.currentIndex.value == 0
                            ? HexColor(AppTheme.primaryColorString!)
                            : Colors.white,
                         AppLocalizations.of(context)!.map,
                        controller.currentIndex.value == 0
                            ? Colors.white
                            : Colors.black,
                        context,
                        width: Get.width * 0.35,
                        height: 45,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.currentIndex.value = 1;
                      },
                      child: customButton(
                        controller.currentIndex.value == 1
                            ? HexColor(AppTheme.primaryColorString!)
                            : Colors.white,
                          AppLocalizations.of(context)!.our_branches,
                        controller.currentIndex.value == 1
                            ? Colors.white
                            : Colors.black,
                        context,
                        width: Get.width * 0.35,
                        height: 45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

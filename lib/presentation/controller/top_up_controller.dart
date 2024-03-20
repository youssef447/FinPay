// ignore_for_file: deprecated_member_use

import 'package:finpay/config/injection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../core/utils/default_snackbar.dart';
import '../../data/data_sources/location_service.dart';
import '../../data/models/branch_model.dart';
import '../../data/repositories/top_up_repo.dart';
import 'package:latlong2/latlong.dart';

class TopupController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxList<BranchModel> branches = RxList<BranchModel>.empty();

  RxBool loadingBranches = false.obs;
  getBranches({required BuildContext context}) async {
    loadingBranches.value = true;
    final response = await locators.get<TopupRepo>().getBranches();
    loadingBranches.value = false;

    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      branches.value = r;
    });
  }

  RxBool loadingPosition = false.obs;
  LatLng center = const LatLng(33.513805, 36.276527);
  Rx<MapOptions> mapOptions = const MapOptions(
    initialCenter: LatLng(33.513805, 36.276527),
    zoom: 15,
  ).obs;
  getCurrentLocation({required BuildContext context}) async {
    try {
      loadingPosition.value = true;
      final response = await locators.get<LocationService>().getPosition();
      loadingPosition.value = false;

      if (context.mounted && response is String) {
        DefaultSnackbar.snackBar(
          context: context,
          message: response,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (context.mounted && response is Position) {
        center = LatLng(response.latitude, response.longitude);
        mapOptions.value = MapOptions(
          initialCenter: center,
          zoom: 15,
        );
      }
    } catch (e) {
      loadingPosition.value = false;

      if (context.mounted) {
        DefaultSnackbar.snackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
  }
}

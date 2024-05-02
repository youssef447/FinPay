// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:finpay/config/injection.dart';
import 'package:finpay/data/models/service_details_model.dart';
import 'package:finpay/data/models/services_model.dart';
import 'package:finpay/data/repositories/service_repo.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/default_dialog.dart';
import '../../core/utils/default_snackbar.dart';

class ServicesController extends GetxController {
  RxBool loading = false.obs;

  late Rxn<ServiceModel> services = Rxn<ServiceModel>();

  RxInt currentIndex = 0.obs;
  String pickedField = '';
  int pickedId = 0;
  pickField(int value) {
    pickedId = value;
    pickedField = services.value!.fields
        .where((element) => element.fieldId == pickedId)
        .first
        .fieldName;
  }

  getServices(BuildContext context) async {
    loading.value = true;
    final response = await locators.get<ServiceRepo>().getAvailableServices();
    loading.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      services.value = r;
    });
  }

  RxBool loadingFieldServices = false.obs;
  late RxList<ServiceDetailsModel> servicesDetails =
      <ServiceDetailsModel>[].obs;
  getFieldServices(
      {required final String fieldId, required BuildContext context}) async {
    loadingFieldServices.value = true;
    final response =
        await locators.get<ServiceRepo>().getFieldServices(fieldId: fieldId);
    loadingFieldServices.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      servicesDetails.value = r;
    });
  }

  RxBool loadingServiceDetails = false.obs;
  RxBool subsrcibed = false.obs;
  RxString detailsErrMessage = ''.obs;
  late Rxn<ServiceDetailsModel> serviceDetailsModel =
      Rxn<ServiceDetailsModel>();

  getServiceDetails(
      {required BuildContext context, required String serviceId}) async {
    detailsErrMessage.value = '';
    loadingServiceDetails.value = true;
    final response = await locators.get<ServiceRepo>().getMyServicesDetails(
          serviceId: serviceId,
        );
    response.fold((l) {
      loadingServiceDetails.value = false;
      detailsErrMessage.value = l.errMessage;
    }, (r) {
      serviceDetailsModel.value = r;
      loadingServiceDetails.value = false;
    });
  }

  RxBool loadingPay = false.obs;

  payService({required BuildContext context, required String serviceId}) async {
    loadingPay.value = true;
    final response = await locators.get<ServiceRepo>().payService(
          serviceId: serviceId,
        );
    loadingPay.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'Done',
      );
    });
  }

  RxBool loadingSubscribtion = false.obs;

  unsubscribe(
      {required BuildContext context, required String serviceId,bool?mySubs}) async {
    loadingSubscribtion.value = true;
    final response = await locators.get<ServiceRepo>().unsubscribe(
          serviceId: serviceId,
        );
    loadingSubscribtion.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'Done',
        btnOkOnPress: () {
       mySubs??false? getServices(context) : getServiceDetails(context: context, serviceId: serviceId);
        },
      );
    });
  }

  subscribe({required BuildContext context, required String serviceId}) async {
    loadingSubscribtion.value = true;
    final response = await locators.get<ServiceRepo>().subscribe(
          serviceId: serviceId,
        );
    loadingSubscribtion.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'Done',
        btnOkOnPress: () {
          getServiceDetails(context: context, serviceId: serviceId);
        },
      );
    });
  }

  RxBool loadingServiceEdit = false.obs;

  deleteService(
      {required BuildContext context, required String serviceId}) async {
    loadingServiceEdit.value = true;
    final response = await locators.get<ServiceRepo>().deleteService(
          serviceId: serviceId,
        );
    loadingServiceEdit.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'Done',
        btnOkOnPress: () {
          getServices(context);
        },
      );
    });
  }

  addService({
    required BuildContext context,
    required String fieldId,
    required String walletId,
    required String amount,
    String? description,
    required String fieldName,
    String? cityEn,
    String? nameAr,
    String? nameEn,
    String? address,
  }) async {
    loadingServiceEdit.value = true;
    final response = await locators.get<ServiceRepo>().addService(
          amount: amount,
          fieldId: fieldId,
          fieldName: fieldName,
          walletId: walletId,
          address: address,
          cityNameEn: cityEn,
          description: description,
          serviceNameAr: nameAr,
          serviceNameEn: nameEn,
        );
    loadingServiceEdit.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'Done',
        btnOkOnPress: () {
          getServices(context);
        },
      );
    });
  }

  toggleService(
      {required BuildContext context, required String serviceId}) async {
    loadingServiceEdit.value = true;
    final response = await locators.get<ServiceRepo>().toggleService(
          serviceId: serviceId,
        );
    loadingServiceEdit.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'Done',
        btnOkOnPress: () {
          getServices(context);
        },
      );
    });
  }

  Rx<File?> file = Rxn<File?>();
  beProvider(
      {required String name,
      required String phone,
      required BuildContext context}) async {
    loading.value = true;
    final response = await locators
        .get<ServiceRepo>()
        .beProvider(name: name, phone: phone, img: file.value);
    loading.value = false;
    response.fold((l) {
      DefaultSnackbar.snackBar(
        context: context,
        message: l.errMessage,
        snackPosition: SnackPosition.TOP,
      );
    }, (r) {
      AwesomeDialogUtil.sucess(
        context: context,
        body: r,
        title: 'Done',
      );
    });
  }

  pickIamge({required ImageSource source, required BuildContext ctx}) async {
    final ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(
      imageQuality: 85,
      source: source,
    );
    if (image != null) {
      file.value = File(image.path);
    }
  }
}

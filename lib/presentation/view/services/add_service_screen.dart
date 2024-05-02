// ignore_for_file: deprecated_member_use

import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/presentation/controller/services_controller.dart';
import 'package:finpay/widgets/custom_textformfield.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  late final TextEditingController nameController,
      nameArController,
      amountController,
      cityEnController,
      addressController,
      descriptionController;
  late final ServicesController serviceController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
    serviceController = Get.find<ServicesController>();
    nameController = TextEditingController();
    cityEnController = TextEditingController();
    nameArController = TextEditingController();
    addressController = TextEditingController();
    descriptionController = TextEditingController();

    amountController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    amountController.dispose();

    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppTheme.isLightTheme == false ? HexColor('#15141f') : Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.add_service,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
        ),
        foregroundColor:
            AppTheme.isLightTheme == false ? Colors.white : Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          child: Center(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    DropdownMenu<int>(
                      hintText: AppLocalizations.of(context)!.pick_field,
                      textStyle:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                      expandedInsets: EdgeInsets.zero,
                      onSelected: (value) {
                        serviceController.pickField(value!);
                      },
                      menuStyle: MenuStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          AppTheme.isLightTheme == false
                              ? const Color(0xff323045)
                              : HexColor(AppTheme.primaryColorString!),
                        ),
                      ),
                      inputDecorationTheme: InputDecorationTheme(
                          suffixIconColor: Colors.white,
                          hintStyle:
                              Theme.of(context).textTheme.headlineLarge!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                          filled: true,
                          fillColor: AppTheme.isLightTheme == false
                              ? const Color(0xff323045)
                              : HexColor(
                                  AppTheme.primaryColorString!,
                                ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          )),
                      dropdownMenuEntries:
                          serviceController.services.value!.fields.map(
                        (e) {
                          return DropdownMenuEntry(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent,
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                            ),
                            value: e.fieldId,
                            label: e.fieldName,
                          );
                        },
                      ).toList(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(Get.context!)!.service_en_name,
                      textEditingController: nameController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(Get.context!)!.service_ar_name,
                      textEditingController: nameArController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(Get.context!)!.city,
                      textEditingController: cityEnController,
                      validator: (e) {
                        if (e!.isEmpty) {
                          return AppLocalizations.of(Get.context!)!
                              .city_required;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.description,
                      textEditingController: descriptionController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.address,
                      textEditingController: addressController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DropdownMenu<int>(
                      hintText: AppLocalizations.of(context)!.pick_wallet,
                      textStyle:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                      expandedInsets: EdgeInsets.zero,
                      onSelected: (value) {
                        Get.find<HomeController>().pickAllWallet(value!);
                      },
                      menuStyle: MenuStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          AppTheme.isLightTheme == false
                              ? const Color(0xff323045)
                              : HexColor(AppTheme.primaryColorString!),
                        ),
                      ),
                      inputDecorationTheme: InputDecorationTheme(
                          suffixIconColor: Colors.white,
                          hintStyle:
                              Theme.of(context).textTheme.headlineLarge!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                          floatingLabelStyle: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                          filled: true,
                          fillColor: AppTheme.isLightTheme == false
                              ? const Color(0xff323045)
                              : HexColor(AppTheme.primaryColorString!),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          )),
                      dropdownMenuEntries:
                          Get.find<HomeController>().allWalletsList.map(
                        (e) {
                          return DropdownMenuEntry(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent,
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                            ),
                            value: e.walletId,
                            label: e.name,
                          );
                        },
                      ).toList(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(
                      () => CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.price,
                        textEditingController: amountController,
                        limit: [FilteringTextInputFormatter.digitsOnly],
                        inputType: TextInputType.number,
                        prefix: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            Get.find<HomeController>()
                                .pickedWalletCurrency
                                .value,
                            style:
                                Theme.of(context).textTheme.headlineLarge!.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue,
                                    ),
                          ),
                        ),
                        validator: (e) {
                          if (e!.isEmpty) {
                            return AppLocalizations.of(Get.context!)!
                                .amount_required;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(
                      () => serviceController.loadingServiceEdit.value
                          ? const IndicatorBlurLoading()
                          : GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  if (serviceController.pickedField.isEmpty) {
                                    Get.defaultDialog(
                                      middleText: AppLocalizations.of(Get.context!)!.must_select_field,
                                      title: AppLocalizations.of(Get.context!)!
                                          .warning,
                                      confirmTextColor: Colors.black,
                                      onConfirm: () {
                                        Get.back();
                                      },
                                    );
                                  } else if (Get.find<HomeController>()
                                      .pickedWalletName
                                      .isEmpty) {
                                    Get.defaultDialog(
                                      middleText:  AppLocalizations.of(Get.context!)!.must_select_wallet,
                                      title: AppLocalizations.of(Get.context!)!
                                          .warning,
                                      confirmTextColor: Colors.black,
                                      onConfirm: () {
                                        Get.back();
                                      },
                                    );
                                  } else if (nameController.text.isEmpty &&
                                      nameArController.text.isEmpty) {
                                    Get.defaultDialog(
                                      middleText:
                                          AppLocalizations.of(Get.context!)!
                                              .must_provide_name,
                                      title: AppLocalizations.of(Get.context!)!
                                          .warning,
                                      confirmTextColor: Colors.black,
                                      onConfirm: () {
                                        Get.back();
                                      },
                                    );
                                  } else {
                                    serviceController.addService(
                                      context: context,
                                      fieldId:
                                          serviceController.pickedId.toString(),
                                      fieldName: serviceController.pickedField,
                                      walletId: Get.find<HomeController>()
                                          .pickedWalletId
                                          .value
                                          .toString(),
                                      amount: amountController.text,
                                      address: addressController.text,
                                      description: descriptionController.text,
                                      cityEn: cityEnController.text,
                                      nameEn: nameController.text,
                                      nameAr: nameArController.text,
                                    );
                                  }
                                }
                              },
                              child: customButton(
                                HexColor(AppTheme.primaryColorString!),
                                AppLocalizations.of(context)!.add,
                                HexColor(AppTheme.secondaryColorString!),
                                context,
                                width: Get.width / 3,
                                height: 40,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

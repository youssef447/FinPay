import 'dart:ui';

import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/style/textstyle.dart';
import '../../../../widgets/custom_textformfield.dart';

class TransfereGroupInfo extends StatelessWidget {
  final String groupName, groupId;
  final GlobalKey<FormState> form;
  final TextEditingController amountController;
  final HomeController controller;

  const TransfereGroupInfo(
      {super.key,
      required this.groupName,
      required this.groupId,
      required this.form,
      required this.amountController,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            DropdownMenu<int>(
              hintText: 'Pick Wallet',
              textStyle: Theme.of(context).textTheme.headline6!.copyWith(
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
                  hintStyle: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                  floatingLabelStyle: Theme.of(context)
                      .textTheme
                      .headline6!
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
              height: 22,
            ),
            Form(
              key: form,
              child: CustomTextFormField(
                fillColor: AppTheme.isLightTheme == false
                    ? const Color(0xff323045)
                    : HexColor(AppTheme.primaryColorString!).withOpacity(0.05),
                hintText: 'amount',
                textEditingController: amountController,
                inputType: TextInputType.number,
                prefix: Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      controller.pickedWalletCurrency.value,
                      style: TextStyle(
                        color: HexColor(AppTheme.primaryColorString!),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                validator: (e) {
                  if (e!.isEmpty) {
                    return 'amount required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        controller.loadingTrasnfere.value
            ? BackdropFilter(
                filter: ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ))
            : const SizedBox(),
      ],
    );
  }
}

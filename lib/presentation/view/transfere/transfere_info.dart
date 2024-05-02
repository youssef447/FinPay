// ignore_for_file: deprecated_member_use

import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swipe/swipe.dart';

import '../../../core/style/images_asset.dart';
import '../../../core/style/textstyle.dart';
import '../../../widgets/custom_textformfield.dart';
import 'transfer_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransfereInfo extends StatefulWidget {
  final String hintText;
  final bool? isGroup;
  final TextEditingController amountController;
  final GlobalKey<FormState> formKey;
  final bool? isCode;

  final TextEditingController? codeController, nameController;
  const TransfereInfo({
    super.key,
    this.isCode,
    required this.hintText,
    required this.formKey,
    this.isGroup,
    this.nameController,
    this.codeController,
    required this.amountController,
  });

  @override
  State<TransfereInfo> createState() => _TransfereInfoState();
}

class _TransfereInfoState extends State<TransfereInfo> {
  late final HomeController homeController;

  @override
  void initState() {
    super.initState();
    //widget.amountController.clear();
    homeController = Get.find<HomeController>();
    homeController.selectedGroupName = null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          widget.isGroup ?? false
              ? Obx(
                  () => homeController.loadingGroups.value
                      ? const LinearProgressIndicator()
                      : DropdownMenu<int>(
                          hintText: AppLocalizations.of(context)!.pick_group,
                          textStyle:
                              Theme.of(context).textTheme.headlineLarge!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                          expandedInsets: EdgeInsets.zero,
                          onSelected: (value) {
                            homeController.selectGroup(value!);
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
                              hintStyle: Theme.of(context)
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
                          dropdownMenuEntries: homeController.groups.map(
                            (e) {
                              return DropdownMenuEntry(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.transparent,
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                ),
                                value: e.id,
                                label: e.name,
                              );
                            },
                          ).toList(),
                        ),
                )
              : CustomTextFormField(
                  hintText: widget.hintText,
                  fillColor: AppTheme.isLightTheme == false
                      ? const Color(0xff323045)
                      : HexColor(AppTheme.primaryColorString!)
                          .withOpacity(0.05),
                  textEditingController: widget.isCode ?? false
                      ? widget.codeController!
                      : widget.nameController!,
                  autoValidate: false,
                  inputType: TextInputType.name,
                  validator: (val) {
                    if (val!.trim().isEmpty) {
                      return widget.isCode ?? false
                          ? AppLocalizations.of(context)!.code_required
                          :  AppLocalizations.of(context)!.name_required;
                    }
                    return null;
                  },
                ),
          const SizedBox(
            height: 50,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppTheme.isLightTheme == false
                  ? const Color(0xff323045)
                  : HexColor(AppTheme.primaryColorString!),
            ),
            width: double.infinity,
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  value: homeController.pickedWalletId.value,
                  iconEnabledColor: Colors.white,
                  dropdownColor: AppTheme.isLightTheme == false
                      ? const Color(0xff323045)
                      : HexColor(AppTheme.primaryColorString!),
                  items: homeController.walletsList.map(
                    (e) {
                      return DropdownMenuItem(
                        value: e.walletId,
                        child: Text(
                          e.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    homeController.pickWallet(value!);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CustomTextFormField(
            fillColor: AppTheme.isLightTheme == false
                ? const Color(0xff323045)
                : HexColor(AppTheme.primaryColorString!).withOpacity(0.05),
            hintText: AppLocalizations.of(context)!.price,
            textEditingController: widget.amountController,
            inputType: TextInputType.number,
            limit: [FilteringTextInputFormatter.digitsOnly],
            autoValidate: false,
            prefix: Obx(
              () => Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  homeController.pickedWalletCurrency.value,
                  style: TextStyle(
                    color: HexColor(AppTheme.primaryColorString!),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            validator: (val) {
              if (widget.isCode ?? false) {
                return null;
              }
              if (val!.isEmpty) {
                return AppLocalizations.of(context)!.amount_required;
              }
              return null;
            },
          ),
          const SizedBox(
            height: 50,
          ),
          Obx(
            () => homeController.method.value == Method.none
                ? const SizedBox()
                : Swipe(
                  horizontalMinDisplacement: 30,
                    onSwipeRight: () {
                      if (homeController.selectedGroupName != null &&
                          widget.isGroup != null &&
                          widget.formKey.currentState!.validate()) {
                        Get.bottomSheet(
                          transferDialog(
                            groupId: homeController.selectedGroupId.toString(),
                            walletId:
                                homeController.pickedWalletId.value.toString(),
                            homeController: homeController,
                            context: context,
                            amountCurrency:
                                homeController.pickedWalletCurrency.value,
                            amount: widget.amountController.text,
                            recipient: homeController.selectedGroupName!,
                            wallet: homeController.pickedWalletName.value,
                            type: 'group',
                          ),
                        );
                      } else if (widget.formKey.currentState!.validate() &&
                          widget.isGroup == null) {
                        Get.bottomSheet(
                          transferDialog(
                            homeController: homeController,
                            context: context,
                            walletId:
                                homeController.pickedWalletId.value.toString(),
                            amountCurrency:
                                homeController.pickedWalletCurrency.value,
                            amount: widget.amountController.text,
                            recipient: widget.isCode ?? false
                                ? widget.codeController!.text
                                : widget.nameController!.text,
                            wallet: homeController.pickedWalletName.value,
                            type: widget.isCode ?? false
                                ? 'transaction_code'
                                : 'username',
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                        bottom: MediaQuery.of(context).padding.bottom + 14,
                      ),
                      child: Container(
                        height: 56,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppTheme.isLightTheme == false
                              ? HexColor(AppTheme.primaryColorString!)
                              : HexColor(AppTheme.primaryColorString!)
                                  .withOpacity(0.05),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppTheme.isLightTheme == false
                                      ? Colors.white
                                      : HexColor(AppTheme.primaryColorString!),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    DefaultImages.swipe,
                                    color: AppTheme.isLightTheme == false
                                        ? HexColor(AppTheme.primaryColorString!)
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                               AppLocalizations.of(context)!.swipe_to_transfere,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

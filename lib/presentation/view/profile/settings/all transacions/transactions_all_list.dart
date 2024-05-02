// ignore_for_file: deprecated_member_use

import 'package:chips_choice/chips_choice.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/view/home/transaction_details.dart';
import 'package:finpay/widgets/custom_textformfield.dart';
import 'package:finpay/widgets/shimmer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../controller/home_controller.dart';
import '../../../../controller/profile_controller.dart';
import '../../../home/widget/transaction_list.dart';

class TransactionsAllListSettings extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();
  TransactionsAllListSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sender,
      AppLocalizations.of(context)!.receiver,
      AppLocalizations.of(context)!.currencies,
      AppLocalizations.of(context)!.date,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor:
            AppTheme.isLightTheme == false ? Colors.white : Colors.black,
      ),
      backgroundColor: AppTheme.isLightTheme == false
          ? const Color(0xff211F32)
          : const Color(0xffFFFFFF),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            controller.chipChoice.value = 0;

            return controller.getAllTransactions(context: context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.sort_by,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.titleLarge!.color,
                        ),
                  ),
                  ChipsChoice<int>.single(
                    value: controller.chipChoice.value,
                    scrollPhysics: const ClampingScrollPhysics(),
                    choiceCheckmark: true,
                    choiceStyle: C2ChipStyle.filled(
                      selectedStyle: C2ChipStyle(
                        backgroundColor: HexColor(
                          AppTheme.primaryColorString!,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                    onChanged: (val) async {
                      if (val == 0) {
                        controller.chipChoice.value = 0;
                        controller.sortedList.value = controller.all;
                      } else if (val == 3) {
                        Get.find<HomeController>().pickedWalletId.value = 0;

                        Get.find<HomeController>().pickedWalletCurrency.value =
                            '';
                        Get.find<HomeController>().pickedWalletName.value = '';
                        Get.defaultDialog(
                          titlePadding: const EdgeInsets.all(20),
                          contentPadding: const EdgeInsets.all(20),
                          title: AppLocalizations.of(context)!.pick_wallet,
                          titleStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                          content: DropdownMenu<int>(
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
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
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
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.transparent,
                                    ),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                  value: e.walletId,
                                  label: e.name,
                                );
                              },
                            ).toList(),
                          ),
                          textConfirm: AppLocalizations.of(context)!.search,
                          onConfirm: () {
                            if (Get.find<HomeController>()
                                .pickedWalletName
                                .isNotEmpty) {
                              Get.back();
                              controller.sortList(
                                v: 3,
                                walletId: Get.find<HomeController>()
                                    .pickedWalletId
                                    .value,
                              );
                            }
                          },
                          buttonColor: AppTheme.isLightTheme
                              ? HexColor(
                                  AppTheme.primaryColorString!,
                                )
                              : Colors.white,
                          confirmTextColor: AppTheme.isLightTheme
                              ? Colors.white
                              : Colors.black,
                        );
                      } else if (val == 4) {
                        final date = await showDatePicker(
                          context: context,
                          lastDate: DateTime.now(),
                          firstDate: DateTime(1990),
                        );
                        if (date != null) {
                          controller.sortList(v: val, date: date);
                        }
                      } else {
                        final nameController = TextEditingController();
                        final GlobalKey<FormState> key = GlobalKey<FormState>();
                        Get.defaultDialog(
                          titlePadding: const EdgeInsets.all(20),
                          contentPadding: const EdgeInsets.all(20),
                          title: val == 1
                              ? AppLocalizations.of(context)!.sender
                              : AppLocalizations.of(context)!.receiver,
                          titleStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                          content: Form(
                            key: key,
                            child: CustomTextFormField(
                              fillColor: AppTheme.isLightTheme == false
                                  ? const Color(0xff323045)
                                  : HexColor(AppTheme.primaryColorString!)
                                      .withOpacity(0.05),
                              hintText: val == 1
                                  ? AppLocalizations.of(context)!.sender_name
                                  : AppLocalizations.of(context)!.receiver_name,
                              textEditingController: nameController,
                            ),
                          ),
                          textConfirm: AppLocalizations.of(context)!.search,
                          onConfirm: () {
                            if (key.currentState!.validate()) {
                              Get.back();
                              val == 1
                                  ? controller.sortList(
                                      v: val,
                                      sender: nameController.text,
                                    )
                                  : controller.sortList(
                                      v: val,
                                      reciever: nameController.text,
                                    );
                            }
                          },
                          buttonColor: AppTheme.isLightTheme
                              ? HexColor(
                                  AppTheme.primaryColorString!,
                                )
                              : Colors.white,
                          confirmTextColor: AppTheme.isLightTheme
                              ? Colors.white
                              : Colors.black,
                        );
                      }
                    },
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: options,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                  ),
                  Expanded(
                    child: controller.loadingAllTxnErr.value
                        ? GestureDetector(
                            onTap: () {
                              controller.getAllTransactions(context: context);
                            },
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.err,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .color,
                                    ),
                              ),
                            ),
                          )
                        : controller.loadingAllTxn.value
                            ? const ShimmerListView(
                                length: 10,
                              )
                            : ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 25,
                                ),
                                itemCount: controller.sortedList.length,
                                padding: const EdgeInsets.only(bottom: 10),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => TransactionDetails(
                                        txnId: controller.sortedList[index].id
                                            .toString(),
                                      ),
                                      transition: Transition.downToUp,
                                      duration:
                                          const Duration(milliseconds: 500),
                                    );
                                  },
                                  child: TransactionList(
                                    image: controller.sortedList[index].image,
                                    title: controller
                                        .sortedList[index].sender.fullName,
                                    subTitle: controller
                                        .sortedList[index].recipient.fullName,
                                    price: controller.sortedList[index].amount,
                                    time: controller
                                        .sortedList[index].creationDate,
                                  ),
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

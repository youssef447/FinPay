import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/style/textstyle.dart';
import '../../../../widgets/custom_textformfield.dart';
import '../../../controller/trade_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../add_trade_service.dart';

class CustomContainer extends StatefulWidget {
  const CustomContainer({super.key});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  late final TextEditingController exchangeRateController;
  late final TradeController tradeController;
  late final GlobalKey<FormState> formKey;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
    tradeController = Get.find<TradeController>();
    exchangeRateController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    exchangeRateController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Obx(
          () => Container(
            padding: EdgeInsets.all(20),
            height: Get.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppTheme.isLightTheme
                  ? HexColor(AppTheme.primaryColorString!)
                  : HexColor("d9f968"),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.from,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.isLightTheme == false
                                ? const Color(0xff323045)
                                : Colors.white,
                          ),
                    ),
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppTheme.isLightTheme == false
                            ? const Color(0xff323045)
                            : HexColor(AppTheme.secondaryColorString!),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          value: tradeController.pickedWalletId.value,
                          iconEnabledColor: AppTheme.isLightTheme == false
                              ? Colors.white
                              : Colors.black,
                          dropdownColor: AppTheme.isLightTheme == false
                              ? const Color(0xff323045)
                              : HexColor(AppTheme.secondaryColorString!),
                          items: tradeController.walletsList.map(
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
                                        color: AppTheme.isLightTheme == false
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            tradeController.pickWallet(value!);
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppTheme.isLightTheme
                            ? Colors.grey[300]
                            : HexColor("bedb5b"),
                      ),
                      child: Text(
                        '1',
                        style:
                            Theme.of(context).textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.to,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.isLightTheme == false
                                ? const Color(0xff323045)
                                : Colors.white,
                          ),
                    ),
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppTheme.isLightTheme == false
                            ? const Color(0xff323045)
                            : HexColor(AppTheme.secondaryColorString!),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          value: tradeController.pickedToWalletId.value,
                          iconEnabledColor: AppTheme.isLightTheme == false
                              ? Colors.white
                              : Colors.black,
                          dropdownColor: AppTheme.isLightTheme == false
                              ? const Color(0xff323045)
                              : HexColor(
                                  AppTheme.secondaryColorString!,
                                ),
                          items: tradeController.walletsList.map(
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
                                        color: AppTheme.isLightTheme == false
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            tradeController.pickToWallet(value!);
                          },
                        ),
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: SizedBox(
                        height: 30,
                        width: 100,
                        child: CustomTextFormField(
                          limit: [FilteringTextInputFormatter.digitsOnly],
                          fillColor: Colors.transparent,
                          hintText: AppLocalizations.of(context)!.exchange_rate,
                          
                          hintStyle:     Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.isLightTheme == false
                                        ? const Color(0xff323045)
                                        : Colors.white,
                                  ),
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                          textEditingController: exchangeRateController,
                          inputType: TextInputType.number,
                          validator: (e) {
                            if (e!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .exchange_rate_required;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -30,
          child: GestureDetector(
            onTap: () {
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).requestFocus(FocusNode());
              }
              if (exchangeRateController.text.isEmpty) {
                Get.defaultDialog(
                  middleText: AppLocalizations.of(context)!.exchange_warning,
                  title: AppLocalizations.of(context)!.warning,
                  confirmTextColor: Colors.black,
                  middleTextStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                  onConfirm: () {
                    Get.back();
                  },
                );
              } else {
                Get.bottomSheet(
                  AddTradeScreen(
                    rate: exchangeRateController.text,
                  ),
                );
              }
            },
            child: CircleAvatar(
              radius: 48,
              backgroundColor: AppTheme.isLightTheme == false
                  ? const Color(0xff15141F)
                  : Colors.white,
              child: CircleAvatar(
                backgroundColor: AppTheme.isLightTheme == false
                    ? Colors.white
                    : HexColor(
                        AppTheme.primaryColorString!,
                      ),
                radius: 37,
                child: Icon(
                  Icons.currency_exchange_rounded,
                  color: AppTheme.isLightTheme == false
                      ? Colors.black
                      : Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -42,
          child: Text(
            AppLocalizations.of(context)!.exchange,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}

import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/trade_controller.dart';
import 'package:finpay/widgets/custom_textformfield.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/custom_button.dart';

class AddTradeScreen extends StatefulWidget {
  final String? rate;
  const AddTradeScreen({super.key, this.rate});

  @override
  State<AddTradeScreen> createState() => _AddTradeScreenState();
}

class _AddTradeScreenState extends State<AddTradeScreen> {
  late final TextEditingController exchangeRateController;
  late final TradeController tradeController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
    tradeController = Get.find<TradeController>();
    exchangeRateController = TextEditingController(text: widget.rate);
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
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: Get.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                25,
              ),
              topRight: Radius.circular(
                25,
              ),
            ),
            color: AppTheme.isLightTheme == false
                ? const Color(0xff15141F)
                : Colors.white,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 25,
          ),
          child: Obx(
            () => Center(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.from,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              AppLocalizations.of(context)!.to,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppTheme.isLightTheme == false
                                    ? const Color(0xff323045)
                                    : HexColor(
                                        AppTheme.primaryColorString!,
                                      ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  value: tradeController.pickedWalletId.value,
                                  iconEnabledColor: Colors.white,
                                  dropdownColor: AppTheme.isLightTheme == false
                                      ? const Color(0xff323045)
                                      : HexColor(AppTheme.primaryColorString!),
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
                                                color: Colors.white,
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
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppTheme.isLightTheme == false
                                    ? const Color(0xff323045)
                                    : HexColor(AppTheme.primaryColorString!),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  value: tradeController.pickedToWalletId.value,
                                  iconEnabledColor: Colors.white,
                                  dropdownColor: AppTheme.isLightTheme == false
                                      ? const Color(0xff323045)
                                      : HexColor(AppTheme.primaryColorString!),
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
                                                  color: Colors.white),
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
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: formKey,
                      child: CustomTextFormField(
                        limit: [FilteringTextInputFormatter.digitsOnly],
                        hintText: AppLocalizations.of(context)!.exchange_rate,
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
                    const SizedBox(
                      height: 30,
                    ),
                    tradeController.loadingAdd.value
                        ? const IndicatorBlurLoading()
                        : GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                tradeController.addTradeService(
                                  exchangeRate: exchangeRateController.text,
                                  context: context,
                                );
                              }
                            },
                            child: customButton(
                              HexColor(AppTheme.primaryColorString!),
                              widget.rate != null
                                  ? AppLocalizations.of(context)!.confirm
                                  : AppLocalizations.of(context)!
                                      .add_trade_service,
                              HexColor(AppTheme.secondaryColorString!),
                              context,
                              width: Get.width / 2.3,
                              height: 40,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: -30,
          child: CircleAvatar(
            backgroundColor: AppTheme.isLightTheme == false
                ? Colors.white
                : HexColor(
                    AppTheme.primaryColorString!,
                  ),
            radius: 37,
            child: Icon(
              Icons.currency_exchange_rounded,
              color:
                  AppTheme.isLightTheme == false ? Colors.black : Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}

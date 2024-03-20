import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/trade_controller.dart';
import 'package:finpay/widgets/custom_textformfield.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_button.dart';

class AddTradeScreen extends StatefulWidget {
  const AddTradeScreen({super.key});

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
    return Container(
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
        vertical: 10,
        horizontal: 25,
      ),
      child: Obx(
        () =>
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              children: [
                Text(
                  'From',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'To',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            Column(children: [
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
                                .headline6!
                                .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
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
                                .headline6!
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
            ]),
          ]),
          Form(
            key: formKey,
            child: CustomTextFormField(
              hintText: 'exchange rate',
              textEditingController: exchangeRateController,
              inputType: TextInputType.number,
              validator: (e) {
                if (e!.isEmpty) {
                  return 'exchange rate required';
                }
                return null;
              },
            ),
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
                    'Add Service',
                    HexColor(AppTheme.secondaryColorString!),
                    context,
                    width: Get.width / 2.5,
                    height: 40,
                  ),
                ),
        ]),
      ),
    );
  }
}

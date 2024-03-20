import 'package:finpay/presentation/controller/trade_controller.dart';
import 'package:finpay/widgets/default_cached_image.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/style/textstyle.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textformfield.dart';

class ExchangeScreen extends StatefulWidget {
  final String tradeId, traderName, fromWallet, toWallet, exchangeRate;
  final TradeController tradeController;
  const ExchangeScreen({
    super.key,
    required this.tradeId,
    required this.traderName,
    required this.fromWallet,
    required this.toWallet,
    required this.exchangeRate,
    required this.tradeController,
  });

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  late TextEditingController amountController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amountController = TextEditingController();
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor:
                  HexColor(AppTheme.primaryColorString!).withOpacity(0.5),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 32,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: const DefaultCachedImage(
                    imgUrl:
                        'https://paytome.net/apis/images/traders/no_image.png',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              widget.traderName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'From',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '1 ${widget.fromWallet}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'To',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${widget.exchangeRate} ${widget.toWallet}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
              key: formKey,
              child: CustomTextFormField(
                hintText: 'exchange amount',
                textEditingController: amountController,
                inputType: TextInputType.number,
                autoValidate: false,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'amount required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => widget.tradeController.loadingExchange.value
                  ? const IndicatorBlurLoading()
                  : GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          widget.tradeController.exchangeTradement(
                              exchangeRate: amountController.text,
                              tradeId: widget.tradeId,
                              context: context);
                        }
                      },
                      child: customButton(
                        HexColor(AppTheme.primaryColorString!),
                        'exchange',
                        HexColor(AppTheme.secondaryColorString!),
                        context,
                        width: Get.width / 2.5,
                        height: 40,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

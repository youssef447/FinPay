import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/style/textstyle.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textformfield.dart';
import '../../../widgets/indicator_loading.dart';
import '../../controller/trade_controller.dart';

class EditTradeService extends StatefulWidget {
  final String exchangeRate,tradeId;
  const EditTradeService({super.key, required this.exchangeRate, required this.tradeId});

  @override
  State<EditTradeService> createState() => _EditTradeServiceState();
}

class _EditTradeServiceState extends State<EditTradeService> {
  late final TextEditingController exchangeRateController;
  final tradeController = Get.find<TradeController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    exchangeRateController = TextEditingController(text: widget.exchangeRate);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [

            SvgPicture.asset(
                          'assets/images/transaction.svg',
                          height: Get.height * 0.6 * 0.2,
                          width: 40,
                        ),
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
          tradeController.loading.value
              ? const IndicatorBlurLoading()
              : GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      tradeController.editTradeService(
                        exchangeRate: exchangeRateController.text,
                        tradeId: widget.tradeId,
                        context: context,
                      );
                    }
                  },
                  child: customButton(
                    HexColor(AppTheme.primaryColorString!),
                    'update',
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

// ignore_for_file: deprecated_member_use

import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/profile_controller.dart';
import 'package:finpay/widgets/custom_textformfield.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../widgets/custom_button.dart';

class AddTicketScreen extends StatefulWidget {
  const AddTicketScreen({super.key});

  @override
  State<AddTicketScreen> createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  late final TextEditingController msgController, idController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
    msgController = TextEditingController();
    idController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    idController.dispose();
    msgController.dispose();

    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Icon(
                  Icons.replay_circle_filled_sharp,
                  color: Color.fromARGB(255, 255, 191, 1),
                  size: 55,
                ),
                const SizedBox(
                  height: 65,
                ),
                CustomTextFormField(
                  hintText: AppLocalizations.of(Get.context!)!
                          .your_message,
                  textEditingController: msgController,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return AppLocalizations.of(Get.context!)!
                          .message_required;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 65,
                ),
                CustomTextFormField(
                  hintText: AppLocalizations.of(Get.context!)!
                          .ticket_id,
                  textEditingController: idController,
                  inputType: TextInputType.number,
                ),
                const SizedBox(
                  height: 65,
                ),
                Obx(
                  () => Get.find<ProfileController>().loadingCreateTicket.value
                      ? const IndicatorBlurLoading()
                      : GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              Get.find<ProfileController>().createTicket(
                                msg: msgController.text,
                                ticketId: idController.text,
                                context: context,
                              );
                            }
                          },
                          child: customButton(
                            HexColor(AppTheme.primaryColorString!),
                           AppLocalizations.of(Get.context!)!
                          .create_ticket,
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
        ),
      ),
    );
  }
}

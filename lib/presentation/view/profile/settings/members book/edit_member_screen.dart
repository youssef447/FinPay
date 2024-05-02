import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/style/textstyle.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_textformfield.dart';
import '../../../../controller/home_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditMemberScreen extends StatefulWidget {
  final bool? edit;
  final String? memberId, memberName, memberNickname;
  const EditMemberScreen(
      {super.key,
      this.edit,
      this.memberId,
      this.memberName,
      this.memberNickname});

  @override
  State<EditMemberScreen> createState() => _EditMemberScreenState();
}

class _EditMemberScreenState extends State<EditMemberScreen> {
  late TextEditingController memberName, memberNickname;
  late GlobalKey<FormState> formKey;
  late final HomeController homeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
    memberName = TextEditingController(text: widget.memberName);
    memberNickname = TextEditingController(text: widget.memberNickname);
    homeController = Get.find<HomeController>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    formKey.currentState?.dispose();
    memberName.dispose();
    memberNickname.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.member_name,
                      textEditingController: memberName,
                      inputType: TextInputType.name,
                      fillColor: AppTheme.isLightTheme == false
                          ? Colors.black
                          : HexColor(AppTheme.secondaryColorString!),
                      validator: (e) {
                        if (e!.isEmpty) {
                          return AppLocalizations.of(context)!.member_name_cant_be_empty;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.nickname,
                      textEditingController: memberNickname,
                      inputType: TextInputType.name,
                      fillColor: AppTheme.isLightTheme == false
                          ? Colors.black
                          : HexColor(AppTheme.secondaryColorString!),
                      validator: (e) {
                        if (e!.isEmpty) {
                          return  AppLocalizations.of(context)!.member_nickname_cant_be_empty;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(
                      () => homeController.loadingEditBookingList.value
                          ? const IndicatorBlurLoading()
                          : GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  widget.edit ?? false
                                      ? homeController.editBookingList(
                                          context: context,
                                          memberId: widget.memberId!,
                                          nickName: memberNickname.text,
                                        )
                                      : homeController.addToBookingList(
                                          username: memberName.text,
                                          nickName: memberNickname.text,
                                          context: context,
                                        );
                                }
                              },
                              child: customButton(
                                HexColor(AppTheme.primaryColorString!),
                                widget.edit ?? false
                                    ? AppLocalizations.of(context)!.update
                                    : AppLocalizations.of(context)!.add,
                                HexColor(AppTheme.secondaryColorString!),
                                context,
                                width: Get.width / 4,
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
        Positioned(
          top: -40,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: AppTheme.isLightTheme == false
                ? HexColor('#15141f')
                : HexColor(AppTheme.primaryColorString!),
            child: const Icon(
              Icons.person,
              size: 50,
            ),
          ),
        ),
      ],
    );
  }
}

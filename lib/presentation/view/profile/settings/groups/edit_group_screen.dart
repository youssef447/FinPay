import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/style/textstyle.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_textformfield.dart';
import '../../../../controller/home_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditGroupScreen extends StatefulWidget {
  final bool? edit;
  final String? groupId, groupName, groupAbout;
  const EditGroupScreen(
      {super.key, this.edit, this.groupId, this.groupName, this.groupAbout});

  @override
  State<EditGroupScreen> createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  late TextEditingController groupName, groupAbout;
  late GlobalKey<FormState> formKey;
  late final HomeController homeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
    groupName = TextEditingController(text: widget.groupName);
    groupAbout = TextEditingController(text: widget.groupAbout);
    homeController = Get.find<HomeController>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    formKey.currentState?.dispose();
    groupName.dispose();
    groupAbout.dispose();

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
                      hintText: AppLocalizations.of(context)!.group_name,
                      textEditingController: groupName,
                      inputType: TextInputType.name,
                      fillColor: AppTheme.isLightTheme == false
                          ? Colors.black
                          : HexColor(AppTheme.secondaryColorString!),
                      validator: (e) {
                        if (e!.isEmpty) {
                          return AppLocalizations.of(context)!.group_name_cant_be_empty;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      hintText:  AppLocalizations.of(context)!.group_about,
                      textEditingController: groupAbout,
                      inputType: TextInputType.name,
                      fillColor: AppTheme.isLightTheme == false
                          ? Colors.black
                          : HexColor(AppTheme.secondaryColorString!),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(
                      () => homeController.loadingAddGroup.value ||
                              homeController.loadingEditGroup.value
                          ? const IndicatorBlurLoading()
                          : GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  widget.edit ?? false
                                      ? homeController.editGroup(
                                          context: context,
                                          groupName: groupName.text,
                                          groupId: widget.groupId!,
                                          groupAbout: groupAbout.text,
                                        )
                                      : homeController.addGroup(
                                          groupName: groupName.text,
                                          groupAbout: groupAbout.text,
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
              Icons.groups,
              size: 50,
            ),
          ),
        ),
      ],
    );
  }
}

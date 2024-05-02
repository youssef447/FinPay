// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/presentation/view/tab_screen.dart';
import 'package:finpay/widgets/custom_container.dart';
import 'package:finpay/widgets/custom_textfield.dart';
import 'package:finpay/widgets/custom_textformfield.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/default_dialog.dart';
import 'settings/setting_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController(
    text: currentUser.fullName,
  );
  final emailController = TextEditingController(
    text: currentUser.email,
  );
  final phoneController = TextEditingController(
    text: currentUser.phone,
  );
  final homeController = Get.find<HomeController>();
  late bool loading;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    nameController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppTheme.isLightTheme == false ? HexColor('#15141f') : Colors.white,
      appBar: AppBar(
        backgroundColor:
            AppTheme.isLightTheme == false ? HexColor('#15141f') : Colors.white,
        foregroundColor:
            AppTheme.isLightTheme == false ? Colors.white : Colors.black,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.my_account,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => const SettingScreen(),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 500),
              );
            },
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).textTheme.headlineLarge!.color,
              size: 25,
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppTheme.isLightTheme == false
                            ? const Color(0xffF5F7FE)
                            : HexColor(AppTheme.primaryColorString!)
                                .withOpacity(0.05),
                        foregroundImage: CachedNetworkImageProvider(
                            currentUser.profilePicUrl),
                      ),
                      SizedBox(
                        height: 28,
                        width: 28,
                        child: SvgPicture.asset(
                          DefaultImages.camera,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    hintText: AppLocalizations.of(context)!.full_name,
                    widget: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(
                        DefaultImages.profileUser,
                      ),
                    ),
                    color: AppTheme.isLightTheme == false
                        ? const Color(0xff211F32)
                        : const Color(0xffF9F9FA),
                    radius: 16,
                    textEditingController: nameController,
                    inputType: TextInputType.name,
                  ),
                  const SizedBox(height: 24),
                  CustomTextFormField(
                    hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        style:Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ), 
                    prefix: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Icon(
                        Icons.email,
                        color: HexColor(AppTheme.primaryColorString!),
                      ),
                    ),
                    hintText: AppLocalizations.of(context)!.email,
                    textEditingController: emailController,
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    hintText: AppLocalizations.of(context)!.phone,
                    widget: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(
                        DefaultImages.call,
                        color: HexColor(AppTheme.primaryColorString!),
                      ),
                    ),
                    color: AppTheme.isLightTheme == false
                        ? const Color(0xff211F32)
                        : const Color(0xffF9F9FA),
                    radius: 16,
                    textEditingController: phoneController,
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(height: 120),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: MediaQuery.of(context).padding.bottom + 14,
                    ),
                    child: loading
                        ? const IndicatorBlurLoading()
                        : CustomButton(
                            title: AppLocalizations.of(context)!.save_changes,
                            onTap: () async {
                              setState(() {
                                loading = true;
                              });
                              if (nameController.text.isNotEmpty) {
                                if (nameController.text !=
                                    currentUser.fullName) {
                                  await homeController.updateProfile(
                                    fullName: nameController.text,
                                    context: context,
                                  );
                                }
                              }
                              if (phoneController.text != currentUser.phone) {
                                if (context.mounted) {
                                  await homeController.updatePhone(
                                    phone: phoneController.text,
                                    context: context,
                                  );
                                }
                              }
                              if (emailController.text.isNotEmpty) {
                                if (emailController.text != currentUser.email) {
                                  if (context.mounted) {
                                    await homeController.updateEmail(
                                      email: emailController.text,
                                      context: context,
                                    );
                                  }
                                }
                              }

                              if (context.mounted) {
                                setState(() {
                                  loading = false;
                                });

                                if (homeController.updateError == false) {
                                  AwesomeDialogUtil.sucess(
                                    context: context,
                                    body: AppLocalizations.of(context)!
                                        .data_updated,
                                    title: 'done',
                                    btnOkOnPress: () {
                                      Get.offAll(
                                        const TabScreen(),
                                      );
                                    },
                                  );
                                }
                              }
                            },
                          ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

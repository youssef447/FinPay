// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/presentation/view/tab_screen.dart';
import 'package:finpay/widgets/custom_container.dart';
import 'package:finpay/widgets/custom_textfield.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/default_dialog.dart';

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
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).textTheme.headline6!.color,
          ),
        ),
        title: Text(
          "My Account",
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
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
                      hintText: "Enter full name",
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
                    CustomTextField(
                      hintText: "edit email",
                      color: AppTheme.isLightTheme == false
                          ? const Color(0xff211F32)
                          : const Color(0xffF9F9FA),
                      radius: 16,
                      textEditingController: emailController,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      hintText: "Enter mobile number",
                      widget: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(
                          DefaultImages.call,
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
                  ],
                ),
              ),
            ],
          ),
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
                    title: "Save changes",
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      if (nameController.text.isNotEmpty) {
                        if (nameController.text != currentUser.fullName) {
                          await homeController.updateProfile(
                              fullName: nameController.text, context: context);
                        }
                      }
                      if (phoneController.text != currentUser.phone) {
                        if (context.mounted) {
                          await homeController.updatePhone(
                              phone: phoneController.text, context: context);
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
                            body: 'Data has been updated',
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
    );
  }
}

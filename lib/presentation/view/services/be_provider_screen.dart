// ignore_for_file: deprecated_member_use

import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/services_controller.dart';
import 'package:finpay/widgets/custom_textformfield.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/style/images_asset.dart';
import '../../../core/utils/globales.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/default_cached_image.dart';

class BeProviderScreen extends StatefulWidget {
  const BeProviderScreen({super.key});

  @override
  State<BeProviderScreen> createState() => _BeProviderScreenState();
}

class _BeProviderScreenState extends State<BeProviderScreen> {
  late final TextEditingController nameController, phoneController;
  late final ServicesController serviceController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
    serviceController = Get.find<ServicesController>();
    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    phoneController.dispose();

    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppTheme.isLightTheme == false ? HexColor('#15141f') : Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : Colors.transparent,
        title: Text(
          'Be A Provider',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Obx(
                () => Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          serviceController.pickIamge(
                            source: ImageSource.gallery,
                            ctx: context,
                          );
                        },
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor:
                                  HexColor(AppTheme.primaryColorString!)
                                      .withOpacity(0.5),
                              child: serviceController.file.value == null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 45,
                                      child: DefaultCachedImage(
                                        imgUrl: currentUser.profilePicUrl,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 45,
                                      backgroundImage: FileImage(
                                        serviceController.file.value!,
                                      ),
                                    ),
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
                      ),
                      const SizedBox(
                        height: 65,
                      ),
                      CustomTextFormField(
                        hintText: 'provider name',
                        textEditingController: nameController,
                        validator: (e) {
                          if (e!.isEmpty) {
                            return 'name required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 65,
                      ),
                      CustomTextFormField(
                        hintText: 'provider phone',
                        textEditingController: phoneController,
                        inputType: TextInputType.number,
                        prefix: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset(
                            DefaultImages.call,
                          ),
                        ),
                        validator: (e) {
                          if (e!.isEmpty) {
                            return 'phone required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 65,
                      ),
                      Obx(
                        () => serviceController.loading.value
                            ? const IndicatorBlurLoading()
                            : GestureDetector(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    serviceController.beProvider(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      context: context,
                                    );
                                  }
                                },
                                child: customButton(
                                  HexColor(AppTheme.primaryColorString!),
                                  'Join',
                                  HexColor(AppTheme.secondaryColorString!),
                                  context,
                                  width: Get.width / 3,
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
        ),
      ),
    );
  }
}

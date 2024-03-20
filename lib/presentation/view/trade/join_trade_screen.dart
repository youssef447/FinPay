
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/trade_controller.dart';
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

class JoinAsTrader extends StatefulWidget {
  const JoinAsTrader({super.key});

  @override
  State<JoinAsTrader> createState() => _JoinAsTraderState();
}

class _JoinAsTraderState extends State<JoinAsTrader> {
  late final TextEditingController nameController ;
  late final TradeController tradeController ;
 late final GlobalKey<FormState> formKey ;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formKey = GlobalKey<FormState>();
    tradeController = Get.find<TradeController>();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
            height: Get.height / 2,

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
        child:Obx(
      () => Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  tradeController.pickIamge(
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
                          HexColor(AppTheme.primaryColorString!).withOpacity(0.5),
                      child:tradeController.file.value == null
                            ?  CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 45,
                        
                        child:  DefaultCachedImage(
                                imgUrl: currentUser.profilePicUrl,
                              ),
                      ):
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 45,
                        backgroundImage:FileImage(
                                tradeController.file.value!,
                              ) ,
                       
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
            ),
                            const SizedBox(height: 35,),
      
            Expanded(
              child: Form(
                key: formKey,
                child: CustomTextFormField(
                  hintText: 'trader name',
                  textEditingController: nameController,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'name required';
                    }
                    return null;
                  },
                ),
              ),
            ),
                                          const SizedBox(height: 35,),
      
            tradeController.loadingJoin.value
                ? const IndicatorBlurLoading()
                : GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        tradeController.joinAsTrader(
                          traderName: nameController.text,
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
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/presentation/controller/profile_controller.dart';
import 'package:finpay/main.dart';
import 'package:finpay/presentation/view/login/reset_pswd_screen.dart';
import 'package:finpay/presentation/view/profile/groups/groups_screen.dart';
import 'package:finpay/presentation/view/profile/widget/custom_row.dart';
import 'package:finpay/presentation/view/profile/widget/notification_view.dart';
import 'package:finpay/presentation/view/profile/widget/social_view.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_controller.dart';
import '../tickets/tickets_screen.dart';
import '../transaction_inquire_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final profileController = Get.put(ProfileController());
  @override
  void initState() {
    setState(() {
      if (AppTheme.isLightTheme == false) {
        profileController.darkMode.value = true;
      } else {
        profileController.darkMode.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int light = 1;
    int dark = 2;
    changeColor(int color) {
      if (color == light) {
        MyApp.setCustomeTheme(context, 6);
      } else {
        MyApp.setCustomeTheme(context, 7);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : Theme.of(context).appBarTheme.backgroundColor,
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
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : Theme.of(context).appBarTheme.backgroundColor,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.settings,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      AppLocalizations.of(context)!.app_settings,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xffA2A0A8),
                          ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const TransactionInquireDetails(),
                        );
                      },
                      child: notificationView(
                        context,
                        AppLocalizations.of(context)!.inquire_for_transactions,
                        const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: () {
                        Get.find<HomeController>().getGroups(context: context);

                        Get.to(
                          () => GroupsScreen(),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.groups_2_sharp,
                            color: AppTheme.isLightTheme
                                ? HexColor(AppTheme.primaryColorString!)
                                : Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            AppLocalizations.of(context)!.groups,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    notificationView(
                      context,
                      AppLocalizations.of(context)!.test_mode,
                      Obx(
                        () => Switch.adaptive(
                          value: profileController.testMode.value,
                          activeColor: HexColor(AppTheme.primaryColorString!),
                          onChanged: (val) {
                            profileController.switchTestMode(
                                val: val, context: context);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    notificationView(
                      context,
                      AppLocalizations.of(context)!.notifications,
                      Obx(
                        () => Switch.adaptive(
                          value: profileController.notificationMode.value,
                          activeColor: HexColor(AppTheme.primaryColorString!),
                          onChanged: (val) {
                            profileController.switchNotificationsMode(
                                val: val, context: context);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    notificationView(
                      context,
                      AppLocalizations.of(context)!.pin_code,
                      Obx(
                        () => Switch.adaptive(
                          value: profileController.pinMode.value,
                          activeColor: HexColor(AppTheme.primaryColorString!),
                          onChanged: (val) {
                            profileController.switchPinMode(
                                val: val, context: context);
                          },
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color(0xffA2A0A8),
                    ),
                    Text(
                      AppLocalizations.of(context)!.general,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xffA2A0A8),
                          ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => ExpansionTile(
                        collapsedIconColor: AppTheme.isLightTheme
                            ? HexColor(
                                AppTheme.primaryColorString!,
                              )
                            : Colors.white,
                        shape: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.change_lang,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        tilePadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.language,
                        ),
                        children: [
                          ListTile(
                            leading: Text(
                              'English',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            trailing: Radio(
                              value: 0 //Languages.english,
                              ,
                              fillColor: MaterialStateProperty.all(
                                AppTheme.isLightTheme
                                    ? HexColor(AppTheme.primaryColorString!)
                                    : Colors.white,
                              ),
                              groupValue: profileController.selectedLang.value,
                              onChanged: (value) {
                                profileController.changeLang(value!);
                              },
                              activeColor:
                                  HexColor(AppTheme.primaryColorString!),
                            ),
                          ),
                          ListTile(
                            trailing: Text(
                              "العربية",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            leading: Radio(
                              value: 1,
                              groupValue: profileController.selectedLang.value,
                              fillColor: MaterialStateProperty.all(
                                AppTheme.isLightTheme
                                    ? HexColor(AppTheme.primaryColorString!)
                                    : Colors.white,
                              ),
                              onChanged: (value) {
                                profileController.changeLang(value!);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    notificationView(
                      context,
                      AppLocalizations.of(context)!.dark_mode,
                      Switch.adaptive(
                        value: profileController.darkMode.value,
                        activeColor: HexColor(AppTheme.primaryColorString!),
                        onChanged: (v) {
                          setState(() {
                            profileController.darkMode.value = v;
                            if (v == true) {
                              changeColor(dark);
                            } else {
                              changeColor(light);
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 22),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ResetPasswordScreen(
                              settings: true,
                            ));
                      },
                      child: customRow(context,
                          AppLocalizations.of(context)!.reset_your_password),
                    ),
                    const SizedBox(height: 32),
                    customRow(
                      context,
                      AppLocalizations.of(context)!.privacy_settings,
                    ),
                    const SizedBox(height: 32),
                    customRow(
                      context,
                      AppLocalizations.of(context)!.help_center,
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: () {
                        profileController.getTickets(context: context);
                        Get.to(
                          () => TicketScreen(),
                        );
                      },
                      child: customRow(
                        context,
                        AppLocalizations.of(context)!.contact_us,
                      ),
                    ),
                    const SizedBox(height: 32),
                    InkWell(
                      onTap: () {
                        profileController.logout(context: context);
                      },
                      child: customRow(
                        context,
                        AppLocalizations.of(context)!.log_out,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      AppLocalizations.of(context)!.follow_us,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xffA2A0A8),
                          ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        socialView(
                          AppTheme.isLightTheme == false
                              ? DefaultImages.twitterdark
                              : DefaultImages.twitter,
                        ),
                        socialView(
                          AppTheme.isLightTheme == false
                              ? DefaultImages.facebookDark
                              : DefaultImages.facebook,
                        ),
                        socialView(
                          AppTheme.isLightTheme == false
                              ? DefaultImages.tiktokDark
                              : DefaultImages.tikTok,
                        ),
                        socialView(
                          AppTheme.isLightTheme == false
                              ? DefaultImages.instagramDark
                              : DefaultImages.instagram,
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Obx(
                        () => profileController.loadingLogout.value
                            ? const Center(child: IndicatorBlurLoading())
                            : InkWell(
                                onTap: () {
                                  profileController.logout(context: context);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.log_out,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xffFB4E4E),
                                      ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        "Finpay © 2021 v1.0",
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff9EA3AE),
                            ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

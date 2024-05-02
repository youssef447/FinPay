// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:finpay/data/models/group_model.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:finpay/widgets/custom_textformfield.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/style/textstyle.dart';
import '../../../../../widgets/custom_button.dart';
part 'widgets/no_members_card.dart';
part 'widgets/add_member_dialog.dart';

class GroupMembersScreen extends StatelessWidget {
  final HomeController homeController;
  final GroupModel group;

  const GroupMembersScreen({
    super.key,
    required this.homeController,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          AppTheme.isLightTheme == false ? HexColor('#15141f') : Colors.white,
      appBar: AppBar(
        foregroundColor: AppTheme.isLightTheme ? Colors.black : Colors.white,
        backgroundColor: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.group_details,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Obx(
          () => homeController.loadingGroupMembers.value
              ? const Center(
                  child: IndicatorBlurLoading(),
                )
              : homeController.err.isNotEmpty
                  ? Center(
                      child: Text(homeController.err.value),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: Get.height * 0.45,
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  top: 45, bottom: 10, left: 15, right: 15),
                              decoration: BoxDecoration(
                                  color: AppTheme.isLightTheme == false
                                      ? const Color(0xff211F32)
                                      : HexColor(AppTheme.primaryColorString!)
                                          .withOpacity(0.8),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              child: homeController.groupMembers.isEmpty
                                  ? NoMembersCard(
                                      group: group,
                                      homeController: homeController,
                                    )
                                  : SingleChildScrollView(
                                      physics: const ClampingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          Text(
                                            group.name,
                                            style: Theme.of(Get.context!)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                          ),
                                          Text(
                                            'Created At: ${group.creationDate}, ${group.creationTime}',
                                            style: Theme.of(Get.context!)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .description,
                                            style: Theme.of(Get.context!)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                          ),
                                          Text(
                                            group.about,
                                            style: Theme.of(Get.context!)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Icon(
                                            Icons.people_alt_rounded,
                                            color: Color.fromARGB(
                                                255, 255, 191, 1),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .members,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 255, 191, 1),
                                                    ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '${homeController.groupMembers.length}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 255, 191, 1)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(
                                              height: 15,
                                              thickness: 1,
                                              color: Colors.white,
                                              endIndent: 25,
                                              indent: 25,
                                            ),
                                            itemBuilder: (context, index) =>
                                                ListTile(
                                              title: Text(
                                                '${AppLocalizations.of(context)!.name} : ${homeController.groupMembers[index].memberUsername}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                              subtitle: Text(
                                                '${AppLocalizations.of(context)!.nickname} : ${homeController.groupMembers[index].memberNickname}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.yellow,
                                                    ),
                                              ),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      final usernameController =
                                                          TextEditingController(
                                                        text: homeController
                                                            .groupMembers[index]
                                                            .memberUsername,
                                                      );
                                                      final nicknameController =
                                                          TextEditingController(
                                                        text: homeController
                                                            .groupMembers[index]
                                                            .memberNickname,
                                                      );

                                                      final GlobalKey<FormState>
                                                          form = GlobalKey<
                                                              FormState>();
                                                      Get.defaultDialog(
                                                        titlePadding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        title:  AppLocalizations.of(context)!.edit_member,
                                                        titleStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                        content:
                                                            AddMemberDialog(
                                                          usernameController:
                                                              usernameController,
                                                          nicknameController:
                                                              nicknameController,
                                                          form: form,
                                                          homeController:
                                                              homeController,
                                                        ),
                                                        textConfirm:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .edit,
                                                        onConfirm: () {
                                                          if (form.currentState!
                                                                  .validate() &&
                                                              homeController
                                                                      .loadingEditGroupMember
                                                                      .value ==
                                                                  false) {
                                                            homeController
                                                                .editGroupMember(
                                                              groupMemberId:
                                                                  homeController
                                                                      .groupMembers[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                              nickName:
                                                                  nicknameController
                                                                      .text,
                                                              context: context,
                                                              groupId: group.id
                                                                  .toString(),
                                                            );
                                                          }
                                                        },
                                                        buttonColor: AppTheme
                                                                .isLightTheme
                                                            ? HexColor(AppTheme
                                                                .primaryColorString!)
                                                            : Colors.white,
                                                        confirmTextColor:
                                                            AppTheme.isLightTheme
                                                                ? Colors.white
                                                                : Colors.black,
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      Get.defaultDialog(
                                                        title:  AppLocalizations.of(context)!.confirm,
                                                        middleText:
                                                             AppLocalizations.of(context)!.delete_member_msg,
                                                        cancel: GestureDetector(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          child: customButton(
                                                            Colors.red,
                                                            AppLocalizations.of(context)!.cancel,
                                                            HexColor(AppTheme
                                                                .secondaryColorString!),
                                                            context,
                                                            width: 100,
                                                            height: 40,
                                                          ),
                                                        ),
                                                        confirm:
                                                            GestureDetector(
                                                          onTap: () {
                                                            homeController
                                                                .deleteGroupMember(
                                                              groupId: group.id
                                                                  .toString(),
                                                              context: context,
                                                              groupMemberId:
                                                                  homeController
                                                                      .groupMembers[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                            );
                                                          },
                                                          child: customButton(
                                                            HexColor(
                                                              AppTheme
                                                                  .primaryColorString!,
                                                            ),
                                                            AppLocalizations.of(context)!.yes,
                                                            HexColor(
                                                              AppTheme
                                                                  .secondaryColorString!,
                                                            ),
                                                            context,
                                                            width: 100,
                                                            height: 40,
                                                          ),
                                                        ),
                                                        confirmTextColor:
                                                            HexColor(
                                                          AppTheme
                                                              .primaryColorString!,
                                                        ),
                                                        cancelTextColor:
                                                            Colors.red,
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            itemCount: homeController
                                                .groupMembers.length,
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                            Positioned(
                              top: -40,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: AppTheme.isLightTheme == false
                                    ? HexColor('#15141f')
                                    : Colors.white,
                                child: Icon(
                                  Icons.groups,
                                  size: 40,
                                  color: HexColor(AppTheme.primaryColorString!),
                                ),
                              ),
                            ),
                            homeController.loadingDeleteGroupMember.value
                                ? BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 2,
                                      sigmaY: 2,
                                    ),
                                    child: const SizedBox(),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            final usernameController = TextEditingController();
                            final nicknameController = TextEditingController();

                            final GlobalKey<FormState> form =
                                GlobalKey<FormState>();
                            Get.defaultDialog(
                              titlePadding: const EdgeInsets.all(20),
                              contentPadding: const EdgeInsets.all(20),
                              title: AppLocalizations.of(context)!.add_member,
                              titleStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                              content: AddMemberDialog(
                                usernameController: usernameController,
                                nicknameController: nicknameController,
                                form: form,
                                homeController: homeController,
                              ),
                              textConfirm: AppLocalizations.of(context)!.add,
                              onConfirm: () {
                                if (form.currentState!.validate() &&
                                    homeController
                                            .loadingEditGroupMember.value ==
                                        false) {
                                  homeController.addGroupMember(
                                    userName: usernameController.text,
                                    nickName: nicknameController.text,
                                    context: context,
                                    groupId: group.id.toString(),
                                  );
                                }
                              },
                              buttonColor: AppTheme.isLightTheme
                                  ? HexColor(AppTheme.primaryColorString!)
                                  : Colors.white,
                              confirmTextColor: AppTheme.isLightTheme
                                  ? Colors.white
                                  : Colors.black,
                            );
                          },
                          child: customButton(
                            const Color.fromARGB(255, 255, 191, 1),
                           AppLocalizations.of(context)!.add_member,
                            Colors.black,
                            fontSize: 13,
                            context,
                            width: Get.width / 2.5,
                            height: 40,
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

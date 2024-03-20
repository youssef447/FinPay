// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:finpay/presentation/controller/profile_controller.dart';
import 'package:finpay/widgets/custom_textformfield.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/style/textstyle.dart';
import '../../../../core/utils/globales.dart';
import '../../../../widgets/custom_button.dart';

class TicketDetailsScreen extends StatelessWidget {
  final ProfileController profileController;

  const TicketDetailsScreen({
    super.key,
    required this.profileController,
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
          'Tickets Details',
          style: Theme.of(context).textTheme.headline6!.copyWith(
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
          () => profileController.loadingTicketsDetails.value
              ? const Center(
                  child: IndicatorBlurLoading(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: Get.height * 0.45,
                      decoration: BoxDecoration(
                        color: AppTheme.isLightTheme == false
                            ? const Color(0xff211F32)
                            : HexColor(AppTheme.primaryColorString!)
                                .withOpacity(0.8),
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Column(
                            children: [
                              ListTile(
                                title: Text(
                                  '#${profileController.details.value!.id}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                ),
                                subtitle: Text(
                                  profileController.details.value!.state,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: profileController
                                                    .details.value!.state ==
                                                'opened'
                                            ? const Color.fromARGB(
                                                255, 183, 255, 101)
                                            : Colors.red,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Icon(
                                Icons.replay_circle_filled_sharp,
                                color: Color.fromARGB(255, 255, 191, 1),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Replies',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontSize: 14,
                                        color: const Color.fromARGB(
                                            255, 255, 191, 1)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: ListView.separated(
                                  physics: const ClampingScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 15,
                                  ),
                                  itemBuilder: (context, index) => ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Reply ID: #${profileController.details.value!.replies[index].id}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                        ),
                                        Text(
                                          'Sent At ${profileController.details.value!.replies[index].createdAt ?? 'N/A'}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontSize: 9,
                                                color: Colors.white,
                                              ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(
                                      'message: ${profileController.details.value!.replies[index].message}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.yellow,
                                          ),
                                    ),
                                  ),
                                  itemCount: profileController
                                      .details.value!.replies.length,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: -20,
                            top: Get.height * 0.45 * 0.5,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: AppTheme.isLightTheme == false
                                  ? HexColor('#15141f')
                                  : Colors.white,
                            ),
                          ),
                          Positioned(
                            left: -20,
                            top: Get.height * 0.45 * 0.5,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: AppTheme.isLightTheme == false
                                  ? HexColor('#15141f')
                                  : Colors.white,
                            ),
                          ),
                          Positioned(
                            right: language == 'ar' ? null : 10,
                            left: language == 'ar' ? 10 : null,
                            top: 15,
                            child: Text(
                              'Created At ${profileController.details.value!.createdAt ?? 'N/A'}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        final replyController = TextEditingController();
                        final GlobalKey<FormState> form =
                            GlobalKey<FormState>();
                        Get.defaultDialog(
                          titlePadding: const EdgeInsets.all(20),
                          contentPadding: const EdgeInsets.all(20),
                          title: 'Reply Ticket',
                          titleStyle:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 15,
                                  ),
                          content: Stack(
                            children: [
                              Form(
                                key: form,
                                child: CustomTextFormField(
                                  fillColor: AppTheme.isLightTheme == false
                                      ? const Color(0xff323045)
                                      : HexColor(AppTheme.primaryColorString!)
                                          .withOpacity(0.05),
                                  hintText: 'your reply',
                                  textEditingController: replyController,
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return 'Message required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              profileController.loadingCreateTicket.value
                                  ? BackdropFilter(
                                      filter: ImageFilter.blur(
                                      sigmaX: 2,
                                      sigmaY: 2,
                                    ))
                                  : const SizedBox(),
                            ],
                          ),
                          textConfirm: 'Send',
                          onConfirm: () {
                            if (form.currentState!.validate() &&
                                profileController.loadingCreateTicket.value ==
                                    false) {
                              profileController.createTicket(
                                msg: replyController.text,
                                context: context,
                                ticketId: profileController.details.value!.id
                                    .toString(),
                                oneDetail: true,
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
                        'Add Reply',
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

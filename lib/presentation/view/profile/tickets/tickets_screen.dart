// ignore_for_file: deprecated_member_use

import 'package:finpay/presentation/controller/profile_controller.dart';
import 'package:finpay/presentation/view/profile/tickets/add_ticket.dart';
import 'package:finpay/presentation/view/profile/tickets/ticket_details_screen.dart';
import 'package:finpay/widgets/no_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/style/textstyle.dart';
import '../../../../core/utils/globales.dart';
import '../../../../widgets/shimmer_tickets.dart';

class TicketScreen extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();
  TicketScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppTheme.isLightTheme == false ? HexColor('#15141f') : Colors.white,
      appBar: AppBar(
        foregroundColor: AppTheme.isLightTheme ? Colors.black : Colors.white,
        backgroundColor:
            AppTheme.isLightTheme == false ? HexColor('#15141f') : Colors.white,
        title: Text(
          'Tickets',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            backgroundColor:
                AppTheme.isLightTheme == false ? Colors.black : Colors.white,
            clipBehavior: Clip.hardEdge,
            ignoreSafeArea: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            const AddTicketScreen(),
          );
        },
        backgroundColor: AppTheme.isLightTheme == false
            ? const Color(0xff211F32)
            : HexColor(AppTheme.primaryColorString!),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.getTickets(context: context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Obx(
            () => controller.loadingTickets.value
                ? const ShimmerTickets()
                : controller.err.isNotEmpty
                    ? Center(
                        child: Text(
                          controller.err,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.isLightTheme
                                        ? HexColor(AppTheme.primaryColorString!)
                                        : Colors.red,
                                  ),
                        ),
                      )
                    : controller.tickets.isEmpty
                        ? Center(
                            child: NoDataScreen(
                              onRefresh: () {
                                controller.getTickets(context: context);
                              },
                              title: 'No Available Tickets',
                            ),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 15,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                if (controller
                                    .tickets[index].replies.isNotEmpty) {
                                  controller.details.value =
                                      controller.tickets[index];
                                  Get.to(
                                    () => TicketDetailsScreen(
                                      profileController: controller,
                                    ),
                                    transition: Transition.downToUp,
                                    duration: const Duration(
                                      milliseconds: 400,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  color: AppTheme.isLightTheme == false
                                      ? const Color(0xff211F32)
                                      : HexColor(
                                          AppTheme.primaryColorString!,
                                        ).withOpacity(0.8),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                ),
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  clipBehavior: Clip.none,
                                  children: [
                                    ListTile(
                                      title: Text(
                                        '#${controller.tickets[index].id}',
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
                                        controller.tickets[index].state,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: controller.tickets[index]
                                                          .state ==
                                                      'opened'
                                                  ? const Color.fromARGB(
                                                      255, 183, 255, 101)
                                                  : Colors.red,
                                            ),
                                      ),
                                    ),
                                    Positioned(
                                      right: -20,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor:
                                            AppTheme.isLightTheme == false
                                                ? HexColor('#15141f')
                                                : Colors.white,
                                      ),
                                    ),
                                    Positioned(
                                      left: -20,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor:
                                            AppTheme.isLightTheme == false
                                                ? HexColor('#15141f')
                                                : Colors.white,
                                      ),
                                    ),
                                    Positioned(
                                      right: language == 'ar' ? null : 10,
                                      left: language == 'ar' ? 10 : null,
                                      top: 10,
                                      child: Text(
                                        'Created At ${controller.tickets[index].createdAt ?? 'N/a'}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: language == 'ar' ? null : 10,
                                      left: language == 'ar' ? 10 : null,
                                      child: Text(
                                        controller
                                                .tickets[index].replies.isEmpty
                                            ? 'No Replies'
                                            : '${controller.tickets[index].replies.length} Replies',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontSize: 10,
                                              color: const Color.fromARGB(
                                                  255, 255, 191, 1),
                                            ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            itemCount: controller.tickets.length,
                          ),
          ),
        ),
      ),
    );
  }
}

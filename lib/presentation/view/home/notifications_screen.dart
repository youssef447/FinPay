// ignore_for_file: deprecated_member_use

import 'package:finpay/presentation/controller/notifications_controller.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/style/textstyle.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationsController controller = Get.put(NotificationsController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor:
            AppTheme.isLightTheme == false ? Colors.white : Colors.black,
        title: Icon(
          size: 30,
          Icons.notifications_active_rounded,
          color: !AppTheme.isLightTheme
              ? Colors.white
              : HexColor(AppTheme.primaryColorString!),
        ),
      ),
      body: Obx(
        () => controller.loading.value
            ? const Center(child: IndicatorBlurLoading())
            : controller.notifications.isEmpty
                ? Center(
                    child: Text(
                      'No Notifications yet',
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  )
                : ListView.separated(
                  physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          controller.notifications[index].title ??
                              controller.notifications[index].body,
                          style: Theme.of(Get.context!)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        subtitle: Text(
                          controller.notifications[index].title == null
                              ? ''
                              : controller.notifications[index].body,
                          style: Theme.of(Get.context!)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        trailing: Column(
                          children: [
                            Text(
                              controller.notifications[index].creationDate
                                  .split(', ')[0],
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              controller.notifications[index].creationDate
                                  .split(', ')[1],
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                    itemCount: controller.notifications.length),
      ),
    );
  }
}

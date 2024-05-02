// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:finpay/presentation/controller/top_up_controller.dart';

import 'package:finpay/widgets/shimmer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/style/textstyle.dart';
import '../../../../widgets/no_data_screen.dart';

class BranchesTap extends StatelessWidget {
  BranchesTap({
    super.key,
  });

  final topupController = Get.find<TopupController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return topupController.getBranches(
          context: context,
        );
      },
      child: Container(
                  padding: const EdgeInsets.only(left:15.0,right:15 ,top: 70),

        decoration: BoxDecoration(
          color: AppTheme.isLightTheme == false ? Colors.black : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Obx(
          () => topupController.loadingBranches.value
              ? const ShimmerListView(
                  length: 10,
                )
              : topupController.branches.isEmpty
                  ? Center(
                      child: NoDataScreen(
                          title: 'No Available Services',
                          onRefresh: () {
                            topupController.getBranches(
                              context: context,
                            );
                          }),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10.0),
                          height: Get.height * 0.15,
                          decoration: BoxDecoration(
                            color: AppTheme.isLightTheme == false
                                ? const Color(0xff211F32)
                                : HexColor(AppTheme.primaryColorString!),
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          child: Row(children: [
                            Expanded(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      topupController
                                          .branches[index].branchName,
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                    ),
                                    Text(
                                      topupController
                                          .branches[index].createdAt
                                          .split(' ')[0],
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ]),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(
                                    Icons.location_pin,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  AutoSizeText(
                                    topupController.branches[index].address,
                                    maxLines: 2,
                                    style: Theme.of(Get.context!)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: topupController.branches.length,
                    ),
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TransactionList extends StatelessWidget {
  final String image, title, subTitle, price, time;
  const TransactionList({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
 SvgPicture.asset(
                image,
                height: 40,
                width: 40,
              ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                maxLines: 2,
                title,
                style: Theme.of(Get.context!).textTheme.bodyText2!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.keyboard_double_arrow_right_outlined,
                    color: HexColor(AppTheme.primaryColorString!),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      subTitle,
                      maxLines: 2,
                      style: Theme.of(Get.context!).textTheme.caption!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                price,
                style: Theme.of(Get.context!).textTheme.bodyText2!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
              ),
           Column(
                      children: [
                        Text(
                          maxLines: 1,
                          time.split(', ')[0],
                          style: Theme.of(Get.context!)
                              .textTheme
                              .caption!
                              .copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        Text(
                          maxLines: 1,
                          time.split(', ')[1],
                          style: Theme.of(Get.context!)
                              .textTheme
                              .caption!
                              .copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ],
    );
  }
}

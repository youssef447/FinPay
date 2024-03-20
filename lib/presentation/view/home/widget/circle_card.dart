// ignore_for_file: deprecated_member_use

import 'package:finpay/core/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget circleCard({String? image, String? title, Color? color}) {
  return Column(
    children: [
      Container(
        height: 72,
        width: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: HexColor(AppTheme.primaryColorString!).withOpacity(0.10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(
                image!,
                fit: BoxFit.fill,
                color: color ?? (AppTheme.isLightTheme == false
                        ? Colors.white
                        : HexColor(AppTheme.primaryColorString!)),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        title!,
        style: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
      )
    ],
  );
}

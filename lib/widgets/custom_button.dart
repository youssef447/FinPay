// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customButton(Color bgClr, String text, Color txtClr, BuildContext context,{double? width,double? height,double?fontSize}) {
  return Container(
    height:height?? 56,
    width: width??Get.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: bgClr,
    ),
    child: Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize:fontSize ??16,
              color: txtClr,
            ),
      ),
    ),
  );
}

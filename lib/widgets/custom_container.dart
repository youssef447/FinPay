// ignore_for_file: deprecated_member_use

import 'package:finpay/core/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final double?width;
  final VoidCallback? onTap;
  const CustomButton({Key? key, this.title, this.onTap, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: 56,
        width:width?? Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: HexColor(AppTheme.primaryColorString!),
        ),
        child: Center(
          child: Text(
            title!,
            style: Theme.of(Get.context!).textTheme.headlineLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}

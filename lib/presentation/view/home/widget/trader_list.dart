// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/widgets/default_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TraderList extends StatelessWidget {
  final String? image;
  final String title, price, time;
  final Widget subtitle;
  final bool? activated;
  final Color? color;

  const TraderList({
    super.key,
    this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.time,
    this.activated,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color ?? (activated ?? false ? Colors.green : Colors.red),
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor:
                HexColor(AppTheme.primaryColorString!).withOpacity(0.5),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 26,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: DefaultCachedImage(
                  imgUrl: image ??
                      'https://paytome.net/apis/images/traders/no_image.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
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
                        color: Colors.white,
                      ),
                ),
                subtitle,
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
                        color: Colors.white,
                      ),
                ),
                Text(
                  maxLines: 1,
                  time,
                  style: Theme.of(Get.context!).textTheme.caption!.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

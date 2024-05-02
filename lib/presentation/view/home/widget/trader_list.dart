// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/widgets/default_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TraderList extends StatelessWidget {
  final String? image;
  final String title, price, time;
  final Widget subtitle;
  final bool? activated;
  final bool? dashboard;
  const TraderList({
    super.key,
    this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.time,
    this.activated,
    this.dashboard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: AppTheme.isLightTheme == false
            ? const Color(0xff211F32)
            : HexColor(
                AppTheme.primaryColorString!,
              ).withOpacity(
                0.9), //color ?? (activated ?? false ? Colors.green : Colors.red),
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
                  style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(
                  height: 10,
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
                  style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                ),
                Text(
                  maxLines: 1,
                  time,
                  style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                dashboard ?? false
                    ? Column(
                      children: [
                        SizedBox(height: 10,),
                        FittedBox(
                          child: Text(
                              activated!
                                  ? AppLocalizations.of(context)!.activated
                                  : AppLocalizations.of(context)!.deactivated,
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color:
                                        activated! ? Colors.greenAccent : Colors.red,
                                  ),
                            ),
                        ),
                      ],
                    )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

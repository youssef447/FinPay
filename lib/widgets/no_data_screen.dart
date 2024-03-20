import 'package:flutter/material.dart';

import '../core/style/textstyle.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoDataScreen extends StatelessWidget {
  final Function()? onRefresh;
  final String title;
  const NoDataScreen({super.key, required this.onRefresh, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).textTheme.caption!.color,
            ),
      ),
      TextButton(
        onPressed: onRefresh,
        child: Text(
          AppLocalizations.of(context)!.refresh,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w400,
                color: AppTheme.isLightTheme
                    ? HexColor(AppTheme.primaryColorString!)
                    : Colors.red,
              ),
        ),
      ),
    ]);
  }
}

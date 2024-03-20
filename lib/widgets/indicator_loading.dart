import 'dart:ui';

import 'package:flutter/material.dart';

import '../core/style/textstyle.dart';

class IndicatorBlurLoading extends StatelessWidget {
  const IndicatorBlurLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2,
        sigmaY: 2,
      ),
      child: CircularProgressIndicator.adaptive(
        backgroundColor: HexColor(
          AppTheme.primaryColorString!,
        ),
      ),
    );
  }
}

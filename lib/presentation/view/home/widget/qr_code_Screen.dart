import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/style/textstyle.dart';
import '../../../../widgets/custom_container.dart';

class QrCodeScreen extends StatelessWidget {
  final String code;
  final Function()? onGenerateTap;
  const QrCodeScreen(
      {super.key, required this.code, required this.onGenerateTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        QrImageView(
          data: code,
          version: QrVersions.auto,
          size: 200.0,
          foregroundColor:  AppTheme.isLightTheme?Colors.black:Colors.white,
        ),
        const SizedBox(height: 5),
        Text(code),
        TextButton(
          onPressed: () {
            Clipboard.setData(
              ClipboardData(text: code),
            );
          },
          child: Text(
            'copy to clipboard',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: HexColor(AppTheme.primaryColorString!),
                ),
          ),
        ),
        CustomButton(
          title: "generate another code",
          onTap: onGenerateTap,
        )
      ],
    );
  }
}

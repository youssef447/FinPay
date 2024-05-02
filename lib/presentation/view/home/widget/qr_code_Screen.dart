import 'package:finpay/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/style/textstyle.dart';
import '../../../../core/utils/default_dialog.dart';
import '../../../../core/utils/default_snackbar.dart';
import '../../../../core/utils/funcs.dart';
import '../../../../widgets/custom_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QrCodeScreen extends StatefulWidget {
  final String code;
  final Function()? onGenerateTap;
  // final   ScreenshotController screenshotController = ScreenshotController();

  const QrCodeScreen(
      {super.key, required this.code, required this.onGenerateTap});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  bool loadingShare = false;
  bool loadingSave = false;

  GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RepaintBoundary(
          key: globalKey,
          child: Column(
            children: [
              QrImageView(
                data: widget.code,
                version: QrVersions.auto,
                size: 200.0,
                foregroundColor: AppTheme.isLightTheme
                    ? HexColor(AppTheme.primaryColorString!)
                    : Colors.white,
              ),
              const SizedBox(height: 5),
              Text(
                '#${widget.code}',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppTheme.isLightTheme
                          ? HexColor(AppTheme.primaryColorString!)
                          : Colors.white,
                    ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            Clipboard.setData(
              ClipboardData(text: widget.code),
            );
          },
          child: Text(
            AppLocalizations.of(context)!.copy,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(
                    255,
                    54,
                    81,
                    74,
                  ),
                ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () async {
                setState(() {
                  loadingShare = true;
                });
                final RenderRepaintBoundary boundary = globalKey.currentContext
                    ?.findRenderObject() as RenderRepaintBoundary;
                try {
                  await captureAndShare(boundary: boundary);
                  setState(() {
                    loadingShare = false;
                  });
                } catch (e) {
                  setState(() {
                    loadingShare = false;
                  });
                  if (context.mounted) {
                    DefaultSnackbar.snackBar(
                        context: context, message: e.toString());
                  }
                }
              },
              icon: loadingShare
                  ? const IndicatorBlurLoading()
                  : CircleAvatar(
                      radius: 22,
                      backgroundColor: AppTheme.isLightTheme
                          ? HexColor(AppTheme.primaryColorString!)
                          : Colors.white,
                      child: Icon(
                        Icons.share_outlined,
                        color: AppTheme.isLightTheme
                            ? Colors.white
                            : HexColor(
                                AppTheme.primaryColorString!,
                              ),
                      ),
                    ),
            ),
            IconButton(
              onPressed: () async {
                setState(() {
                  loadingSave = true;
                });
                final RenderRepaintBoundary boundary = globalKey.currentContext
                    ?.findRenderObject() as RenderRepaintBoundary;
                try {
                  await captureAndShare(boundary: boundary, save: true);
                  setState(() {
                    loadingSave = false;
                  });
                  if (context.mounted) {
                    AwesomeDialogUtil.sucess(
                      context: context,
                      body: AppLocalizations.of(context)!.qr_saved,
                      title: 'Done',
                      duration: const Duration(seconds: 2),
                    );
                  }
                } catch (e) {
                  setState(() {
                    loadingSave = false;
                  });
                  if (context.mounted) {
                    DefaultSnackbar.snackBar(
                        context: context, message: e.toString());
                  }
                }
              },
              icon: loadingSave
                  ? const IndicatorBlurLoading()
                  :  CircleAvatar(
                radius: 22,
                backgroundColor: AppTheme.isLightTheme
                    ? HexColor(AppTheme.primaryColorString!)
                    : Colors.white,
                child: Icon(
                  Icons.save_alt_sharp,
                  color: AppTheme.isLightTheme
                      ? Colors.white
                      : HexColor(
                          AppTheme.primaryColorString!,
                        ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        CustomButton(
          width: Get.width / 2,
          title: AppLocalizations.of(context)!.generate_another_code,
          onTap: widget.onGenerateTap,
        ),
      ],
    );
  }
}

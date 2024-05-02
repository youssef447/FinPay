import 'dart:io';

import 'package:finpay/core/utils/default_snackbar.dart';
import 'package:finpay/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QrScannerView extends StatefulWidget {
  final bool? transfereScreen, homeView;
  const QrScannerView({super.key, this.transfereScreen, this.homeView});

  @override
  State<QrScannerView> createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  late bool loading;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutHeight: 200,
              cutOutWidth: 200,
            ),
          ),
          loading
              ? Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) {
        setState(() {
          loading = true;
        });
        controller.pauseCamera().then((value) {
          Get.find<HomeController>().getTrxnDetailsViaCode(
            context: context,
            code: scanData.code!,
            transfereScreen: widget.transfereScreen ?? false,
            homeView: widget.homeView ?? false,
          );
        });
      },
      onError: (err) {
        DefaultSnackbar.snackBar(
            context: context, message: AppLocalizations.of(context)!.qr_err);
        Get.back();
      },
      cancelOnError: false,
      onDone: () {},
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

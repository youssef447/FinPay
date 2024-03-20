// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:finpay/core/animations/fade_down_up.dart';
import 'package:finpay/core/style/images_asset.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/core/utils/default_snackbar.dart';
import 'package:finpay/presentation/view/tab_screen.dart';
import 'package:finpay/widgets/indicator_loading.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../widgets/custom_button.dart';

class TransferSucessScreen extends StatefulWidget {
  final String type;
  final String money, amountCurrency;
  final String recipient;
  final String wallet;
  final String txnNumber;

  const TransferSucessScreen({
    Key? key,
    required this.type,
    required this.money,
    required this.wallet,
    required this.txnNumber,
    required this.recipient,
    required this.amountCurrency,
  }) : super(key: key);

  @override
  State<TransferSucessScreen> createState() => _TransferSucessScreenState();
}

class _TransferSucessScreenState extends State<TransferSucessScreen> {
  GlobalKey globalKey = GlobalKey();
  bool loadingShare = false;
  final date =
      DateFormat('M/d/y, hh:mm aa').format(DateTime.now()).split(', ')[0];
  final time =
      DateFormat('M/d/y, hh:mm aa').format(DateTime.now()).split(', ')[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.isLightTheme == false
          ? const Color(0xff15141F)
          : Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.isLightTheme == false
            ? const Color(0xff15141F)
            : HexColor(AppTheme.primaryColorString!).withOpacity(0.05),
        elevation: 0,
        leading: InkWell(
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).textTheme.headline6!.color,
          ),
        ),
        title: Text(
          "Transfer Success",
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: FadeDownUp(
              child: RepaintBoundary(
                key: globalKey,
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    color: AppTheme.isLightTheme == false
                        ? const Color(0xff15141F)
                        : HexColor(AppTheme.primaryColorString!)
                            .withOpacity(0.05),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, left: 10, right: 10, top: 50),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: Get.width,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 80),
                                Text(
                                  widget.type == 'group'
                                      ? widget.txnNumber
                                      : "#${widget.txnNumber}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                ),
                                widget.type != 'group'
                                    ? TextButton(
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                                text: widget.txnNumber),
                                          );
                                        },
                                        child: Text(
                                          'copy to clipboard',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  letterSpacing: 1,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color.fromARGB(
                                                      255, 54, 81, 74)),
                                        ),
                                      ):const SizedBox()
                                     ,
                                const SizedBox(width: 16),
                                Text(
                                  '${widget.amountCurrency} ${widget.money}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Recipient",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                    ),
                                    Text(
                                      widget.recipient,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Divider(color: Colors.white),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      "Transfer with",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset(
                                      DefaultImages.creditcard1,
                                      height: 24,
                                      width: 24,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      widget.wallet,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                const Divider(
                                  color: Colors.white,
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Transfer Amount",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                    ),
                                    Text(
                                      '${widget.amountCurrency} ${widget.money}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Divider(
                                  color: Colors.white,
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Date",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                    ),
                                    Text(
                                      date,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Divider(
                                  color: Colors.white,
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Time",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                    ),
                                    Text(
                                      time,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: -50,
                          child: SizedBox(
                            height: 104,
                            width: 152,
                            child: SvgPicture.asset(
                              DefaultImages.transferSucess,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppTheme.isLightTheme == false
                    ? HexColor('#15141f')
                    : Theme.of(context).appBarTheme.backgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await captureAndShare();
                    },
                    icon: CircleAvatar(
                      radius: 25,
                      backgroundColor: AppTheme.isLightTheme
                          ? HexColor(AppTheme.primaryColorString!)
                          : Colors.white,
                      child: loadingShare
                          ? const IndicatorBlurLoading()
                          : Icon(
                              Icons.share_outlined,
                              color: AppTheme.isLightTheme
                                  ? Colors.white
                                  : HexColor(AppTheme.primaryColorString!),
                            ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(
                        const TabScreen(),
                      );
                    },
                    child: customButton(
                      HexColor(AppTheme.primaryColorString!),
                      'Done',
                      HexColor(AppTheme.secondaryColorString!),
                      context,
                      width: Get.width / 3,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> captureAndShare() async {
    setState(() {
      loadingShare = true;
    });
    try {
      final RenderRepaintBoundary boundary =
          globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getApplicationDocumentsDirectory();

      String path = '${directory.path}/image/reciept.png';
      final File imgFile = await File(path).create(recursive: true);

      await imgFile.writeAsBytes(pngBytes);

      await Share.shareXFiles(
        [XFile(imgFile.path)],
      );
      setState(() {
        loadingShare = false;
      });
    } catch (e) {
      setState(() {
        loadingShare = false;
      });
      if (mounted) {
        DefaultSnackbar.snackBar(
            context: context, message: 'error sharing reciept');
      }
    }
  }
}

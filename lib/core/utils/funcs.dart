import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

Future<void> printReciept(RenderRepaintBoundary boundary) async {
  ui.Image image = await boundary.toImage();
  ByteData? byteData = await image.toByteData(
    format: ui.ImageByteFormat.png,
  );
  Uint8List pngBytes = byteData!.buffer.asUint8List();

  /* final directory = await getApplicationDocumentsDirectory();

  String path = '${directory.path}/image/details_reciept.png';
  final File imgFile = await File(path).create(recursive: true);

  await imgFile.writeAsBytes(pngBytes);
  final Uint8List list =
      (await rootBundle.load(path)).buffer.asUint8List(); */
  final doc = pw.Document();
  doc.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(
            pw.MemoryImage(pngBytes),
          ),
        ); // Center
      },
    ),
  );
  // await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save());
}

Future<void> captureAndShare(
    {required RenderRepaintBoundary boundary, bool? save}) async {
  ui.Image image = await boundary.toImage(pixelRatio: 5);
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData!.buffer.asUint8List();

  if (save ?? false) {
    await ImageGallerySaver.saveImage(pngBytes,quality: 100);
    return;
  }

  final Directory directory = await getTemporaryDirectory();

  String path = '${directory.path}/image/details_reciept.png';
  final File imgFile = await File(path).create(recursive: true);

  await imgFile.writeAsBytes(pngBytes);
  final xfile = XFile(imgFile.path);

  await Share.shareXFiles(
    [xfile],
  );
}

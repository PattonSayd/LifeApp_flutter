import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';

import '../pages/create_receipt/receipt_webview/webview.dart';


void pickFromGallery(BuildContext context) async {
  var image = await ImagePicker().getImage(source: ImageSource.gallery);
  if (image == null) return;
  String? url = await Scan.parse(image.path);

  getFiscalFromUrl(url! ,context);
}

void getFiscalFromUrl(String url , BuildContext context) {
  if (url.contains("monitoring.e-kassa.gov.az")) {
    String fiscal = url.substring(46, 58);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReceiptWebViewScreen(
              fiscal: fiscal,
            )));
  }
}
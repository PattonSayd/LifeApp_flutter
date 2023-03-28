import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';

import '../examine_receipt/examine_receipt_screen.dart';
import 'webview_controller.dart';


class ReceiptWebViewScreen extends StatefulWidget {
  const ReceiptWebViewScreen({Key? key, this.fiscal}) : super(key: key);
  final String? fiscal;

  @override
  State<ReceiptWebViewScreen> createState() => _ReceiptWebViewScreenState();
}

class _ReceiptWebViewScreenState extends State<ReceiptWebViewScreen> {
  final WebViewController controller = Get.put(WebViewController());
  InAppWebViewController? webViewController;

  void getReceiptImage() async {
    var html = await webViewController!.evaluateJavascript(
        source: "window.document.getElementsByTagName('img')[1].outerHTML;");
    var document = parse(html);
    dom.Element? link = document.querySelector('img');
    String? image = link != null ? link.attributes['src'] : '';
    if (mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExamineReceipt(
                    fiscal: widget.fiscal!,
                    base64: image,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: defaultText(widget.fiscal!, color: Colors.white, fontSize: 16),
        centerTitle: true,
        backgroundColor: CustomColors.primary,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse(
                    'https://monitoring.e-kassa.gov.az/#/index?doc=${widget.fiscal!}'),
              ),
              onLoadStart: (inAppWebViewController, uri) async {
                webViewController = inAppWebViewController;
              },
              onLoadStop: (inAppWebViewController, uri) {
                controller.updateReceiptLoaded();
              }),
          Obx(() => controller.receiptLoaded.value
              ? Positioned(
                  bottom: 20,
                  child: ElevatedButton(
                      onPressed: () {
                        getReceiptImage();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.primary,
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.9, 50)),
                      child: defaultText('Yadda saxla', color: Colors.white)))
              : const SizedBox())
        ],
      ),
    );
  }
}

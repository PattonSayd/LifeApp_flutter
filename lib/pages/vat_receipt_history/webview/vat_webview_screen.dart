import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/vat_receipt_history/receipt_history_all/vat_receipts_screen.dart';
import 'package:lifeapp/pages/vat_receipt_history/receipts_history/vat_receipts_history_screen.dart';
import 'package:lifeapp/pages/vat_receipt_history/webview/vat_receipt_controller.dart';
import 'package:lifeapp/widgets/custom_button.dart';

class VatHistoryWebViewScreen extends StatefulWidget {
  const VatHistoryWebViewScreen({Key? key}) : super(key: key);

  @override
  State<VatHistoryWebViewScreen> createState() =>
      _VatHistoryWebViewScreenState();
}

class _VatHistoryWebViewScreenState extends State<VatHistoryWebViewScreen> {
  final CookieManager _cookieManager = CookieManager.instance();
  final VatReceiptController _vatReceiptController =
      Get.put(VatReceiptController());

  String _cookieStr = '';

  Future<void> getCookies() async {
    List<Cookie> cookies = await _cookieManager.getCookies(
        url: Uri.parse('https://edvgerial.kapitalbank.az'));
    for (Cookie cookie in cookies) {
      _cookieStr += cookie.name + '=' + cookie.value + ';';
    }
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<VatReceiptController>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: Obx(() => _vatReceiptController.downloadStarted.value
              ? Row(
                  children: [
                    defaultText(
                        _vatReceiptController.receipts.length.toString() +
                            ' ' +
                            Languages.of(context)!.receipt +
                            Languages.of(context)!.downloaded,
                        color: Colors.white,
                        fontSize: 16),
                    SizedBox(
                      width: 10,
                    ),
                    CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    )
                  ],
                )
              : SizedBox()),
          centerTitle: true),
      body: Stack(
        alignment: Alignment.center,
        children: [
          InAppWebView(
            onLoadStop: (controller, url) async {
              if (url ==
                  Uri.parse('https://edvgerial.kapitalbank.az/az/dashboard')) {
                await getCookies();
                await _vatReceiptController.loadAllReceipts(_cookieStr);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VatReceiptsScreen(
                            receipts: _vatReceiptController.receipts)));
              }
            },
            initialUrlRequest: URLRequest(
                url: Uri.parse('https://edvgerial.kapitalbank.az/az/login')),
          ),
        ],
      ),
    ));
  }
}

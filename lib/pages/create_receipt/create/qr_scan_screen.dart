import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/pages/create_receipt/receipt_webview/webview.dart';
import 'package:lifeapp/pages/main/main_controller.dart';
import 'package:lifeapp/utils/qr_scan.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../localization/languages/languages.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({Key? key, this.isBottomBar = false}) : super(key: key);

  final bool isBottomBar;

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final MainController mainController = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController fiscalTec = TextEditingController();

  bool isFlash = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: !widget.isBottomBar
              ? GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.arrowLeftSvg,
                      width: 24.w,
                      height: 24.w,
                    ),
                  ),
                )
              : null,
          centerTitle: true,
          title: defaultText(
            Languages.of(context)!.addReceipt,
            fontSize: 16.csp,
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                await controller?.toggleFlash();
                isFlash = !isFlash;
                setState(() {});
              },
              child: SvgPicture.asset(
                Assets.fluentFlashSvg,
                fit: BoxFit.scaleDown,
                color: isFlash ? Colors.yellow : Colors.black,
              ),
            ),
            SizedBox(width: 14.w),
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: !widget.isBottomBar ? 0.70.sh : 0.60.sh,
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: _buildQrView(context),
                ),
              ),
            ),
            Positioned(
              top: (!widget.isBottomBar ? 0.70.sh : 0.60.sh) - 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      pickFromGallery(context);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10.ch),
                          height: 52.ch,
                          width: 52.ch,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.primary.withOpacity(0.24),
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              )
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(Assets.imageFillSvg),
                          ),
                        ),
                        defaultText(
                          Languages.of(context)!.selectPhoto,
                          fontSize: 10.csp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 42.w),
                  InkWell(
                    onTap: () async {
                      // await controller?.pauseCamera();
                      // await Future.delayed(Duration(seconds: 2));
                      // Navigator.pushNamed(context, "/qr-scan-add");
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 68.ch,
                          width: 68.ch,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.primary,
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.primary.withOpacity(0.24),
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              )
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(Assets.boxCameraSvg),
                          ),
                        ),
                        defaultText(""),
                      ],
                    ),
                  ),
                  SizedBox(width: 36.w),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/qr-scan-manual-add");
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10.ch),
                          height: 52.ch,
                          width: 52.ch,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.primary.withOpacity(0.24),
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              )
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(Assets.keyboardFillSvg),
                          ),
                        ),
                        defaultText(
                          Languages.of(context)!.enterManually,
                          fontSize: 10.csp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: fiscalTec,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        controller!.pauseCamera();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReceiptWebViewScreen(
                                    fiscal: fiscalTec.text.trim())));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 22)),
                      child: Text(Languages.of(context)!.send))
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.w
        : 300.w;
    return QRView(
      key: qrKey,
      onQRViewCreated: (QRViewController controller) {
        setState(() {
          this.controller = controller;
        });
        controller.scannedDataStream.listen((scanData) async {
          await controller.pauseCamera();
          String url = scanData.code.toString();
          getFiscalFromUrl(url, context);
        });
        controller.resumeCamera();
      },
      overlay: QrScannerOverlayShape(
        borderColor: CustomColors.primary,
        borderRadius: 8.r,
        borderLength: 24.w,
        borderWidth: 10.ch,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      // _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text('no Permission')));
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

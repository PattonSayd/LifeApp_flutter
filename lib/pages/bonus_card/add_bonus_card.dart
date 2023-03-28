import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/bonus_card/add_bonus_card_controller.dart';
import 'package:lifeapp/widgets/custom_button.dart';
import 'package:lifeapp/widgets/custom_text_field.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/system_padding.dart';

final TextEditingController nameTEC = TextEditingController();
final TextEditingController codeTEC = TextEditingController();

class AddBonusCard extends StatefulWidget {
  const AddBonusCard({Key? key}) : super(key: key);

  @override
  _AddBonusCardState createState() => _AddBonusCardState();
}

class _AddBonusCardState extends State<AddBonusCard> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
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
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AddManual();
                    });
              },
              icon: Icon(
                Icons.edit_note,
                color: Colors.black,
              ),
            ),
          ],
          centerTitle: true,
          title: defaultText(
            Languages.of(context)!.addBonusCard,
            fontSize: 16.csp,
          ),
        ),
        body: Center(
          child: Container(
            height: 0.75.sh,
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: _buildQrView(context),
            ),
          ),
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
        controller.scannedDataStream.listen((scanData) {
          controller.pauseCamera();
          String code = scanData.code.toString();
          showDialog(
              context: context,
              builder: (context) {
                return EnterName(
                  code: code,
                );
              });
        });
        controller.resumeCamera();
      },
      overlay: QrScannerOverlayShape(
          borderColor: CustomColors.primary,
          borderRadius: 8.r,
          borderLength: 24.w,
          borderWidth: 10.ch,
          cutOutWidth: MediaQuery.of(context).size.width * 0.8,
          cutOutHeight: MediaQuery.of(context).size.height * 0.4),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('no Permission')),
      // );
    }
  }
}

class AddManual extends StatelessWidget {
  AddManual({Key? key}) : super(key: key);

  final AddBonusCardController controller = Get.put(AddBonusCardController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SystemPadding(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: codeTEC,
                    hint: Languages.of(context)!.enterCode,
                    hasBorder: true,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: nameTEC,
                    hint: Languages.of(context)!.enterName,
                    hasBorder: true,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() => CustomButton(
                      onPressed: () {
                        controller.add(
                            codeTEC.text.trim(), nameTEC.text.trim());
                        nameTEC.text = "";
                        codeTEC.text = "";
                      },
                      width: MediaQuery.of(context).size.width,
                      loading: controller.loading.value,
                      text: Languages.of(context)!.save))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EnterName extends StatelessWidget {
  EnterName({Key? key, this.code}) : super(key: key);

  final AddBonusCardController controller = Get.put(AddBonusCardController());
  final String? code;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SystemPadding(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: nameTEC,
                    hint: Languages.of(context)!.enterName,
                    hasBorder: true,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() => CustomButton(
                      onPressed: () {
                        controller.add(code!, nameTEC.text.trim());
                        nameTEC.text = "";
                      },
                      width: MediaQuery.of(context).size.width,
                      loading: controller.loading.value,
                      text: Languages.of(context)!.save))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

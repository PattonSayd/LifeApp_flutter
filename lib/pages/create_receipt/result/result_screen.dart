import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/pages/create_receipt/examine_receipt/models/product.dart';
import 'package:lifeapp/pages/receipt/receipt_screen.dart';

import '../../../../../constants/assets.dart';
import '../../../../../constants/fonts.dart';
import '../../../../../localization/languages/languages.dart';
import '../../../../../widgets/custom_button.dart';
import '../examine_receipt/models/save_receipt.dart';
import 'result_controller.dart';

class CreateReceiptResultScreen extends StatefulWidget {
  const CreateReceiptResultScreen({Key? key ,this.products ,this.saveReceipt}) : super(key: key);
  final List<Product>? products;
  final SaveReceipt? saveReceipt;
  @override
  State<CreateReceiptResultScreen> createState() => _CreateReceiptResultScreenState();
}

class _CreateReceiptResultScreenState extends State<CreateReceiptResultScreen> {
  final ResultController resultController = Get.put(ResultController());

  @override
  void initState() {
    super.initState();
    resultController.saveReceipt(widget.products!, widget.saveReceipt!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() => resultController.loading.value
            ? Center(child: CircularProgressIndicator.adaptive())
            : Success()),
      )),
    );
  }
}

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  final ResultController resultController = Get.put(ResultController());

  // final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            behavior: HitTestBehavior.opaque,
            child: SvgPicture.asset(
              Assets.closeSvg,
              width: 30,
            )),
        Column(
          children: [
            Obx(() => SvgPicture.asset(
                  resultController.success.value
                      ? Assets.success
                      : Assets.alreadyExists,
                  width: MediaQuery.of(context).size.width * 0.4,
                )),
            SizedBox(
              height: 10,
              width: MediaQuery.of(context).size.width,
            ),
            Obx(() => defaultText(
                resultController.success.value
                    ? Languages.of(context)!.successOperation
                    : Languages.of(context)!.thisReceiptAlreadyExists,
                fontSize: 25))
          ],
        ),
        Column(
          children: [
            CustomButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/pages.main", (route) => false);
              },
              text: Languages.of(context)!.scanAgain,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              onPressed: () {
                // mainController.pageIndex.value = 0;
                Navigator.pushNamedAndRemoveUntil(
                    context, "/pages.main", (route) => false);
              },
              text: Languages.of(context)!.mainMenu,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReceiptScreen(
                              fiscal: resultController.uploadedReceiptId.value
                                  .toString(),
                              type: "kassa",
                            )));
              },
              text: Languages.of(context)!.lookReceipt,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        )
      ],
    );
  }
}

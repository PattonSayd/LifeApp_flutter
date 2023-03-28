import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/costs/tag/tag_controller.dart';
import 'package:lifeapp/pages/quick_add/quick_add.dart';
import 'package:lifeapp/pages/quick_add/quick_add_controller.dart';
import 'package:lifeapp/utils/qr_scan.dart';
import 'package:lifeapp/widgets/custom_button.dart';
import 'package:lifeapp/widgets/custom_text_field.dart';
import 'package:lifeapp/widgets/system_padding.dart';

import '../../constants/colors.dart';

final TextEditingController nameTEC = TextEditingController();
final TextEditingController priceTEC = TextEditingController();

class QuickAddDialog extends StatefulWidget {
  const QuickAddDialog({Key? key}) : super(key: key);

  @override
  State<QuickAddDialog> createState() => _QuickAddDialogState();
}

class _QuickAddDialogState extends State<QuickAddDialog> {
  final QuickAddController quickAddController = Get.put(QuickAddController());

  @override
  void initState() {
    quickAddController.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      margin: EdgeInsets.only(top: 150),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Row(
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
                GestureDetector(
                    onTap: () async {
                      Navigator.pushNamed(context, "/qr-scan");
                    },
                    child: Container(
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
                    )),
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
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => defaultText(
                      quickAddController.items.length.toString() + '/10')),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context, builder: (_) => CostDialog());
                    },
                    behavior: HitTestBehavior.opaque,
                    child: SvgPicture.asset(
                      Assets.addSvg,
                      width: 40,
                      height: 40,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: defaultText(Languages.of(context)!.productName)),
                  Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: defaultText(Languages.of(context)!.price,
                          textAlign: TextAlign.center)),
                  Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: defaultText(Languages.of(context)!.count,
                          textAlign: TextAlign.center)),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: defaultText(Languages.of(context)!.total)),
                  Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox()),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(() => quickAddController.loading.value
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : ListView.builder(
                      itemCount: quickAddController.items.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _mainCostItem(
                            quickAdd: quickAddController.items[index],
                            quickAddController: quickAddController,
                            itemIndex: index,
                            onTap: () {});
                      })),
            )
          ],
        ),
      ),
    );
  }

  Widget _mainCostItem(
      {required QuickAdd quickAdd,
      required QuickAddController quickAddController,
      required int itemIndex,
      required VoidCallback onTap}) {
    List<Text> values = [];
    List<double> valuesDouble = [];
    int count = 5;

    for (int i = count - 1; i > 0; i--) {
      double changedPrice = quickAdd.itemPrice! - i * 0.1;
      Text value = defaultText(changedPrice.toStringAsFixed(2) + ' AZN',
          fontSize: 13.csp, fontWeight: FontWeight.w400);
      values.add(value);
      valuesDouble.add(changedPrice);
    }

    for (int i = 0; i < count; i++) {
      double changedPrice = quickAdd.itemPrice! + i * 0.1;
      Text value = defaultText(changedPrice.toStringAsFixed(2) + ' AZN',
          fontSize: 13.csp, fontWeight: FontWeight.w400);

      values.add(value);
      valuesDouble.add(changedPrice);
    }

    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: 161.w,
        height: 70.ch,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(105, 15, 183, 0.08),
              blurRadius: 4,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    nameTEC.text = quickAdd.itemName!;
                    priceTEC.text = quickAdd.itemPrice!.toString();
                    showDialog(
                        context: context,
                        builder: (_) => CostEditDialog(
                              quickAdd: quickAdd,
                            ));
                  },
                  behavior: HitTestBehavior.opaque,
                  child: defaultText(
                    quickAdd.itemName!,
                    fontSize: 14.csp,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: CupertinoPicker(
                    onSelectedItemChanged: (index) {
                      quickAddController.sendList[itemIndex].price =
                          valuesDouble[index];
                      quickAddController.sendList.refresh();
                    },
                    scrollController:
                        FixedExtentScrollController(initialItem: count - 1),
                    magnification: 1.1,
                    itemExtent: 25,
                    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                      background: Colors.transparent,
                    ),
                    children: values)),
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: CupertinoPicker(
                    onSelectedItemChanged: (index) {
                      quickAddController.sendList[itemIndex].count = index + 1;
                      quickAddController.sendList.refresh();
                    },
                    magnification: 1.1,
                    itemExtent: 25,
                    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                      background: Colors.transparent,
                    ),
                    children: List<Widget>.generate(10, (index) {
                      return defaultText((index + 1).toString(),
                          fontSize: 14.csp, fontWeight: FontWeight.w400);
                    }))),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Obx(() => defaultText(
                    (quickAddController.sendList[itemIndex].count! *
                            quickAddController.sendList[itemIndex].price!)
                        .toStringAsFixed(2),
                    fontSize: 14.csp,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center))),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: GestureDetector(
                    onTap: () {
                      quickAddController.addToCosts(itemIndex);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: Obx(() => SizedBox(
                            width: 30,
                            height: 30,
                            child: quickAddController
                                    .sendList[itemIndex].loading!
                                ? CircularProgressIndicator.adaptive()
                                : Icon(Icons.add, color: CustomColors.primary),
                          )),
                    ))),
          ],
        ),
      ),
    );
  }
}

class CostDialog extends StatelessWidget {
  CostDialog({Key? key}) : super(key: key);
  final QuickAddController controller = Get.put(QuickAddController());
  final TagController tagController = Get.put(TagController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SystemPadding(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 420,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: SvgPicture.asset(
                    Assets.closeSvg,
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
              ),
              centerTitle: true,
              title: defaultText(
                Languages.of(context)!.addPayment,
                fontSize: 16.csp,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultText(
                      Languages.of(context)!.productName,
                      fontSize: 14.csp,
                    ),
                    SizedBox(height: 10.ch),
                    CustomTextField(
                      controller: nameTEC,
                      hint: Languages.of(context)!.productName,
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        bottom: 15.ch,
                        top: 15.ch,
                      ),
                      fontSize: 16.csp,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 20.ch),
                    defaultText(
                      Languages.of(context)!.price,
                      fontSize: 14.csp,
                    ),
                    SizedBox(height: 10.ch),
                    CustomTextField(
                      controller: priceTEC,
                      hint: "0.00 AZN",
                      keyboardType: TextInputType.number,
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 15.ch,
                        bottom: 15.ch,
                      ),
                      fontSize: 16.csp,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 10.ch),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Select tag'),
                      items: tagController.tagResponse.value!.tags!
                          .map((item) => DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(
                                  item.name!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        controller.selectedTagId.value = int.parse(value!);
                      },
                    ),
                    SizedBox(height: 40.ch),
                    Obx(() => CustomButton(
                          width: MediaQuery.of(context).size.width,
                          fontSize: 16.csp,
                          fontWeight: FontWeight.w600,
                          loading: controller.saveLoading.value,
                          onPressed: () async {
                            await controller.create(
                                nameTEC.text.trim(),
                                double.parse(priceTEC.text.trim()),
                                controller.selectedTagId.value);
                            Navigator.pop(context);
                            nameTEC.text = "";
                            priceTEC.text = "";
                          },
                          text: Languages.of(context)!.save,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CostEditDialog extends StatelessWidget {
  CostEditDialog({Key? key, this.quickAdd}) : super(key: key);

  final QuickAdd? quickAdd;
  final TagController tagController = Get.find();
  final QuickAddController quickAddController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SystemPadding(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 420,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  nameTEC.text = '';
                  priceTEC.text = '';
                  Navigator.pop(context);
                },
                child: Center(
                  child: SvgPicture.asset(
                    Assets.closeSvg,
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
              ),
              centerTitle: true,
              title: defaultText(
                Languages.of(context)!.addPayment,
                fontSize: 16.csp,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultText(
                      Languages.of(context)!.productName,
                      fontSize: 14.csp,
                    ),
                    SizedBox(height: 10.ch),
                    CustomTextField(
                      controller: nameTEC,
                      hint: Languages.of(context)!.productName,
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        bottom: 15.ch,
                        top: 15.ch,
                      ),
                      fontSize: 16.csp,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 20.ch),
                    defaultText(
                      Languages.of(context)!.price,
                      fontSize: 14.csp,
                    ),
                    SizedBox(height: 10.ch),
                    CustomTextField(
                      controller: priceTEC,
                      hint: "0.00 AZN",
                      keyboardType: TextInputType.number,
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 15.ch,
                        bottom: 15.ch,
                      ),
                      fontSize: 16.csp,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 10.ch),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Select tag'),
                      items: tagController.tagResponse.value!.tags!
                          .map((item) => DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(
                                  item.name!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        quickAddController.selectedTagId.value =
                            int.parse(value!);
                      },
                    ),
                    SizedBox(height: 40.ch),
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Obx(() => CustomButton(
                                fontSize: 16.csp,
                                fontWeight: FontWeight.w600,
                                loading: quickAddController.deleteLoading.value,
                                onPressed: () async {
                                  await quickAddController
                                      .delete(quickAdd!.id!);
                                  Navigator.pop(context);
                                },
                                text: Languages.of(context)!.delete,
                                backgroundColor: CustomColors.red,
                                outlineColor: CustomColors.red,
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Obx(() => CustomButton(
                                fontSize: 16.csp,
                                fontWeight: FontWeight.w600,
                                loading: quickAddController.saveLoading.value,
                                onPressed: () async {
                                  await quickAddController.edit(
                                      nameTEC.text.trim(),
                                      double.parse(priceTEC.text.trim()),
                                      quickAddController.selectedTagId.value,
                                      quickAdd!.id!);
                                  nameTEC.text = "";
                                  priceTEC.text = "";
                                  Navigator.pop(context);
                                },
                                text: Languages.of(context)!.save,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

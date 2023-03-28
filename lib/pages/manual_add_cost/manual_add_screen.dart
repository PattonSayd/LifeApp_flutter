import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/manual_add_cost/cost_item.dart';
import 'package:lifeapp/pages/manual_add_cost/manual_cost_add_controller.dart';
import 'package:lifeapp/widgets/custom_button.dart';
import 'package:lifeapp/widgets/custom_text_field.dart';

final TextEditingController nameTEC = TextEditingController();
final TextEditingController priceTEC = TextEditingController();
final TextEditingController countTEC = TextEditingController();
final TextEditingController commentTEC = TextEditingController();
final TextEditingController storeTEC = TextEditingController();

class ManualAddScreen extends StatefulWidget {
  ManualAddScreen({Key? key}) : super(key: key);

  @override
  State<ManualAddScreen> createState() => _ManualAddScreenState();
}

class _ManualAddScreenState extends State<ManualAddScreen> {
  final ManualCostAddController controller = Get.put(ManualCostAddController());

  @override
  void dispose() {
    super.dispose();
    Get.delete<ManualCostAddController>();
  }

  @override
  void initState() {
    super.initState();
    openCostDialog();
  }

  void openCostDialog() async {
    await Future.delayed(Duration(milliseconds: 100));
    showDialog(context: context, builder: (_) => CostDialog());
  }

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
      bottomNavigationBar: Container(
        height: 170.ch,
        padding: EdgeInsets.symmetric(vertical: 20.ch, horizontal: 28.w),
        decoration: BoxDecoration(
          color: CustomColors.white,
          boxShadow: [
            BoxShadow(
              color: CustomColors.primary.withOpacity(0.06),
              offset: Offset(0, -2),
              blurRadius: 6,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextField(
              controller: storeTEC,
              hint: Languages.of(context)!.storeName,
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                bottom: 15.ch,
                top: 15.ch,
              ),
              fontSize: 16.csp,
              fontWeight: FontWeight.w400,
            ),
            Obx(() => CustomButton(
                  fontSize: 16.csp,
                  fontWeight: FontWeight.w600,
                  onPressed: () async {
                    await controller.upload(storeTEC.text.toString());
                    storeTEC.text = '';
                  },
                  loading: controller.loading.value,
                  text: Languages.of(context)!.save,
                )),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: defaultText(Languages.of(context)!.productName)),
                  Expanded(
                      flex: 1,
                      child: defaultText(Languages.of(context)!.price,
                          textAlign: TextAlign.center)),
                  Expanded(
                      flex: 1,
                      child: defaultText(Languages.of(context)!.count,
                          textAlign: TextAlign.center)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Obx(() => ListView.builder(
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) {
                      ManualCostItem manualCostItem = controller.items[index];
                      return CostItem(
                        manualCostItem: manualCostItem,
                      );
                    })),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder: (_) => CostDialog());
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: defaultText(Languages.of(context)!.addToReceipt,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.primary),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CostItem extends StatelessWidget {
  CostItem({Key? key, this.manualCostItem}) : super(key: key);
  ManualCostItem? manualCostItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: CustomColors.primary)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 3, child: defaultText(manualCostItem!.name!)),
              Expanded(
                  flex: 1,
                  child: defaultText(manualCostItem!.price.toString(),
                      textAlign: TextAlign.center)),
              Expanded(
                  flex: 1,
                  child: defaultText(manualCostItem!.count.toString(),
                      textAlign: TextAlign.center)),
            ],
          )
        ],
      ),
    );
  }
}

class CostDialog extends StatelessWidget {
  CostDialog({Key? key}) : super(key: key);
  final ManualCostAddController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Scaffold(
          backgroundColor: Colors.transparent,
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
                  Obx(() => CustomTextField(
                        controller: priceTEC,
                        errorText: controller.priceError.value != ""
                            ? controller.priceError.value
                            : null,
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
                      )),
                  SizedBox(height: 20.ch),
                  defaultText(
                    Languages.of(context)!.count,
                    fontSize: 14.csp,
                  ),
                  SizedBox(height: 10.ch),
                  Obx(() => CustomTextField(
                        controller: countTEC,
                        errorText: controller.countError.value != ""
                            ? controller.countError.value
                            : null,
                        hint: "1",
                        keyboardType: TextInputType.number,
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 15.ch,
                          bottom: 15.ch,
                        ),
                        fontSize: 16.csp,
                        fontWeight: FontWeight.w400,
                      )),
                  SizedBox(height: 20.ch),
                  defaultText(
                    Languages.of(context)!.comment,
                    fontSize: 14.csp,
                  ),
                  SizedBox(height: 10.ch),
                  CustomTextField(
                    controller: commentTEC,
                    hint: Languages.of(context)!.comment,
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 15.ch,
                      bottom: 15.ch,
                    ),
                    fontSize: 16.csp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 20.ch),
                  defaultText(
                    Languages.of(context)!.paymentType,
                    fontSize: 14.csp,
                  ),
                  SizedBox(height: 10.ch),
                  Container(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    height: 66.ch,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.primary.withOpacity(0.06),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultText(
                              Languages.of(context)!.other,
                              color: CustomColors.textSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                            defaultText(
                              Languages.of(context)!.cash,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 38.ch,
                          child: CustomButton(
                            onPressed: () {},
                            text: Languages.of(context)!.change,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.ch),
                  CustomButton(
                    width: MediaQuery.of(context).size.width,
                    fontSize: 16.csp,
                    fontWeight: FontWeight.w600,
                    onPressed: () {
                      controller.priceError.value = "";
                      controller.countError.value = "";

                      if (priceTEC.text.trim() == "") {
                        controller.priceError.value =
                            Languages.of(context)!.thisFieldCantBeEmpty;
                        return;
                      }
                      if (countTEC.text.trim() == "") {
                        controller.countError.value =
                            Languages.of(context)!.thisFieldCantBeEmpty;
                        return;
                      }

                      controller.add(
                          nameTEC.text.trim(),
                          double.parse(priceTEC.text.trim()),
                          int.parse(countTEC.text.trim()),
                          commentTEC.text.trim());
                      Navigator.pop(context);
                      nameTEC.text = "";
                      priceTEC.text = "";
                      countTEC.text = "";
                      commentTEC.text = "";
                    },
                    text: Languages.of(context)!.addToReceipt,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

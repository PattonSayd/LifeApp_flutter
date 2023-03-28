import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/targets/add/add_target_controller.dart';
import 'package:lifeapp/pages/targets/add/target_requeset_dto.dart';
import 'package:lifeapp/widgets/custom_button.dart';
import 'package:lifeapp/widgets/custom_text_field.dart';

class AddTarget extends StatefulWidget {
  @override
  State<AddTarget> createState() => _AddTargetState();
}

class _AddTargetState extends State<AddTarget> {
  final TextEditingController startDateTEC = TextEditingController();
  final TextEditingController endDateTEC = TextEditingController();
  final TextEditingController nameTEC = TextEditingController();
  final TextEditingController commentTEC = TextEditingController();
  final TextEditingController priceTEC = TextEditingController();
  final AddTargetController addTargetController =
      Get.put(AddTargetController());

  String? selectedDateOne;
  String? selectedDateTwo;

  List<String> list = [];

  bool repeatCost = false;

  String? selectCategory;

  @override
  void dispose() {
    super.dispose();
    Get.delete<AddTargetController>();
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
          Languages.of(context)!.addTarget,
          fontSize: 16.csp,
        ),
      ),
      bottomNavigationBar: Container(
        height: 144.ch,
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
          children: [
            Obx(() => CustomButton(
                  fontSize: 16.csp,
                  fontWeight: FontWeight.w600,
                  loading: addTargetController.loading.value,
                  onPressed: () {
                    addTargetController.nameError.value = "";
                    addTargetController.priceError.value = "";
                    addTargetController.startDateError.value = "";
                    addTargetController.endDateError.value = "";
                    if (nameTEC.text.trim() == "") {
                      addTargetController.nameError.value =
                          Languages.of(context)!.thisFieldCantBeEmpty;
                      return;
                    }
                    if (priceTEC.text.trim() == "") {
                      addTargetController.priceError.value =
                          Languages.of(context)!.thisFieldCantBeEmpty;
                      return;
                    }
                    if (startDateTEC.text.trim() == "") {
                      addTargetController.startDateError.value =
                          Languages.of(context)!.thisFieldCantBeEmpty;
                      return;
                    }
                    if (endDateTEC.text.trim() == "") {
                      addTargetController.endDateError.value =
                          Languages.of(context)!.thisFieldCantBeEmpty;
                      return;
                    }

                    addTargetController.create(TargetRequestDto(
                        name: nameTEC.text.trim(),
                        comment: commentTEC.text.trim(),
                        sum: double.parse(priceTEC.text.trim()),
                        startDate: startDateTEC.text.trim(),
                        endDate: endDateTEC.text.trim()));

                    nameTEC.text = "";
                    commentTEC.text = "";
                    priceTEC.text = "";
                    startDateTEC.text = "";
                    endDateTEC.text = "";
                    selectedDateOne = "";
                    selectedDateTwo = "";
                  },
                  text: Languages.of(context)!.save,
                )),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 28.w,
          right: 28.w,
          top: 20.ch,
          bottom: 20.ch,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => CustomTextField(
                  controller: nameTEC,
                  hint: Languages.of(context)!.targetName,
                  errorText: addTargetController.nameError.value != ""
                      ? addTargetController.nameError.value
                      : null,
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 15.ch,
                    top: 15.ch,
                  ),
                  fontSize: 16.csp,
                  fontWeight: FontWeight.w400,
                )),
            SizedBox(height: 36.ch),
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
                bottom: 15.ch,
                top: 15.ch,
              ),
              fontSize: 16.csp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 36.ch),
            defaultText(
              Languages.of(context)!.amount,
              fontSize: 14.csp,
            ),
            SizedBox(height: 10.ch),
            Obx(() => CustomTextField(
                  controller: priceTEC,
                  hint: "0.00 AZN",
                  keyboardType: TextInputType.number,
                  errorText: addTargetController.priceError.value != ""
                      ? addTargetController.priceError.value
                      : null,
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 15.ch,
                    bottom: 15.ch,
                  ),
                  fontSize: 16.csp,
                  fontWeight: FontWeight.w400,
                )),
            SizedBox(height: 16.ch),
            Row(
              children: [
                Flexible(
                  child: Obx(() => DateTimePicker(
                        controller: startDateTEC,
                        decoration: InputDecoration(
                          errorText:
                              addTargetController.startDateError.value != ""
                                  ? addTargetController.startDateError.value
                                  : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Color(0xFFF2F2F2)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Color(0xFFF2F2F2)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: CustomColors.primary),
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 16.w,
                            right: 0.w,
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(10.w),
                            child: SvgPicture.asset(
                              Assets.calendarSvg,
                            ),
                          ),
                          hintText: Languages.of(context)!.fromDate,
                          hintStyle: TextStyle(
                            fontSize: 16.csp,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.textBlack,
                          ),
                        ),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateMask: 'dd.MM.yyyy',
                        onChanged: (val) {
                          var dateFormat = val.split("-");
                          selectedDateOne =
                              "${dateFormat[2]}.${dateFormat[1]}.${dateFormat[0]}";
                        },
                        validator: (val) {
                          return null;
                        },
                        onSaved: (val) {},
                      )),
                ),
                SizedBox(width: 10.w),
                Flexible(
                  child: Obx(() => DateTimePicker(
                        controller: endDateTEC,
                        decoration: InputDecoration(
                          errorText:
                              addTargetController.endDateError.value != ""
                                  ? addTargetController.endDateError.value
                                  : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Color(0xFFF2F2F2)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Color(0xFFF2F2F2)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: CustomColors.primary),
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 16.w,
                            right: 0.w,
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(10.w),
                            child: SvgPicture.asset(
                              Assets.calendarSvg,
                            ),
                          ),
                          hintText: Languages.of(context)!.toDate,
                          hintStyle: TextStyle(
                            fontSize: 16.csp,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.textBlack,
                          ),
                        ),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateMask: 'dd.MM.yyyy',
                        onChanged: (val) {
                          var dateFormat = val.split("-");
                          selectedDateTwo =
                              "${dateFormat[2]}.${dateFormat[1]}.${dateFormat[0]}";
                        },
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        // onSaved: (val) => selectedDateTwo = val,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _filterChip(String title, {required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(38.r),
        color: CustomColors.lightGrey,
      ),
      padding: EdgeInsets.only(
        left: 16.w,
        top: 16.ch,
        bottom: 16.ch,
        right: 14.w,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: onPressed,
            child: SvgPicture.asset(
              Assets.deleteRoundedSvg,
              width: 20.ch,
              height: 20.ch,
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _filterCheck(
      {required String title,
      required VoidCallback onTap,
      required bool check}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 12.w),
            height: 24.ch,
            width: 24.ch,
            decoration: BoxDecoration(
              // color: check ? CustomColors.primary : CustomColors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: check ? CustomColors.primary : Color(0xFFBCB4C0),
                width: 2.w,
              ),
            ),
            child: check
                ? SvgPicture.asset(
                    Assets.filterCheckSvg,
                    height: 30.ch,
                    width: 30.ch,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          defaultText(
            title,
            fontSize: 16.csp,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}

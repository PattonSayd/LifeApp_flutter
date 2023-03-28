import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/costs/tag/tag_controller.dart';
import 'package:lifeapp/pages/costs/tag/tag_screen.dart';
import 'package:lifeapp/pages/expenditure/expenditure_controller.dart';
import 'package:lifeapp/pages/expenditure/expenditure_request.dart';
import 'package:lifeapp/widgets/custom_button.dart';
import 'package:lifeapp/widgets/custom_text_field.dart';

class ExpenditurePlansAddScreen extends StatefulWidget {
  @override
  State<ExpenditurePlansAddScreen> createState() =>
      _ExpenditurePlansAddScreenState();
}

class _ExpenditurePlansAddScreenState extends State<ExpenditurePlansAddScreen> {
  TextEditingController startDateTEC = TextEditingController();
  TextEditingController endDateTEC = TextEditingController();
  TextEditingController nameTEC = TextEditingController();
  TextEditingController limitTEC = TextEditingController();
  final ExpenditureController controller = Get.put(ExpenditureController());
  final TagController tagController = Get.put(TagController());

  String? selectedDateOne;
  String? selectedDateTwo;

  List<String> list = [];

  bool repeatCost = false;

  String? selectCategory;

  @override
  void dispose() {
    super.dispose();
    Get.delete<ExpenditureController>();
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
              Assets.arrowLeftSvg,
              width: 24.w,
              height: 24.w,
            ),
          ),
        ),
        centerTitle: true,
        title: defaultText(
          Languages.of(context)!.add,
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
            Obx(()=>CustomButton(
              fontSize: 16.csp,
              fontWeight: FontWeight.w600,
              loading: controller.loading.value,
              onPressed: () {
                ExpenditureRequest expenditureRequest = ExpenditureRequest(
                    name: nameTEC.text.trim(),
                    limit: double.parse(limitTEC.text.trim()),
                    type: controller.type.value,
                    startDate: startDateTEC.text.trim(),
                    endDate: endDateTEC.text.trim(),
                    tagId: controller.type.value == "tag"
                        ? controller.selectedTagId.value
                        : null,
                    categoryId:
                    controller.type.value == "category"
                        ? controller.selectedCategoryId.value
                        : null,
                    periodType: repeatCost ? 'repeat' : 'onetime');
                controller.create(expenditureRequest);
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
            CustomTextField(
              controller: nameTEC,
              hint: Languages.of(context)!.myCostPlan,
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
              Languages.of(context)!.limit,
              fontSize: 14.csp,
            ),
            SizedBox(height: 10.ch),
            CustomTextField(
              controller: limitTEC,
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 15.ch,
                bottom: 15.ch,
              ),
              hint: Languages.of(context)!.limit,
              fontSize: 16.csp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 16.ch),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select type'),
              value: null,
              items: [
                {'index': 0, 'name': Languages.of(context)!.tag},
                {'index': 1, 'name': Languages.of(context)!.category}
              ]
                  .map((item) => DropdownMenuItem<String>(
                        value: item['index'].toString(),
                        child: Text(
                          item['name'].toString(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                controller.type.value = value == '0' ? "tag" : "category";
              },
            ),
            SizedBox(height: 16.ch),
            Obx(() {
              if (controller.type.value == "tag") {
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Select tag'),
                  value:
                      tagController.tagResponse.value!.tags![0].id.toString(),
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
                );
              } else if (controller.type.value == "category") {
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Select category'),
                  value: controller.categories[0].id.toString(),
                  items: controller.categories
                      .map((item) => DropdownMenuItem<String>(
                            value: item.id.toString(),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                item.name!,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.selectedCategoryId.value = int.parse(value!);
                  },
                );
              } else {
                return SizedBox();
              }
            }),
            SizedBox(height: 16.ch),
            Row(
              children: [
                Flexible(
                  child: DateTimePicker(
                    controller: startDateTEC,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.zero,
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
                      constraints: BoxConstraints(
                        maxHeight: 50.ch,
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
                  ),
                ),
                SizedBox(width: 10.w),
                Flexible(
                  child: DateTimePicker(
                    controller: endDateTEC,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.zero,
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
                      constraints: BoxConstraints(
                        maxHeight: 50.ch,
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
                  ),
                ),
              ],
            ),
            SizedBox(height: 22.ch),
            _filterCheck(
              title: Languages.of(context)!.repetitiveCostPlan,
              check: repeatCost,
              onTap: () {
                repeatCost = !repeatCost;
                setState(() {});
              },
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

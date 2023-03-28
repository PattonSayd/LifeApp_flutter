import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/fonts.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../localization/languages/languages.dart';

final TextEditingController fromTEC = TextEditingController();
final TextEditingController toTEC = TextEditingController();

class FilterDatePicker extends StatefulWidget {
  const FilterDatePicker({Key? key,required this.onSelected}) : super(key: key);

  final VoidCallback onSelected;

  @override
  State<FilterDatePicker> createState() => _FilterDatePickerState();
}

class _FilterDatePickerState extends State<FilterDatePicker> {

  DatePickerController datePickerController = Get.put(DatePickerController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Flexible(
            child: DateTimePicker(
              controller: fromTEC,
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
              dateMask: 'yyyy-MM-dd',
              onChanged: (val) {
                var dateFormat = val.split("-");
                datePickerController.fromDate.value =
                "${dateFormat[2]}.${dateFormat[1]}.${dateFormat[0]}";
                widget.onSelected();
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
              controller: toTEC,
              decoration: InputDecoration(
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
              dateMask: 'yyyy-MM-dd',
              onChanged: (val) {
                var dateFormat = val.split("-");
                datePickerController.toDate.value =
                "${dateFormat[2]}.${dateFormat[1]}.${dateFormat[0]}";
                widget.onSelected();
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
    );
  }
}

class DatePickerController extends GetxController {
  RxString fromDate = "".obs;
  RxString toDate = "".obs;
}

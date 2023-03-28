import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/receipts/receipts_controller.dart';
import 'package:lifeapp/widgets/custom_button.dart';
import 'package:lifeapp/pages/receipts/receipt_response.dart';

import '../receipt/receipt_screen.dart';

class ReceiptsScreen extends StatefulWidget {
  const ReceiptsScreen({Key? key}) : super(key: key);

  @override
  State<ReceiptsScreen> createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {
  bool isFilter = false;
  bool isSearch = false;

  final TextEditingController selectedDateOneController =
      TextEditingController();
  final TextEditingController selectedDateTwoController =
      TextEditingController();
  final ReceiptsController receiptsController = Get.put(ReceiptsController());

  ScrollController? scrollController;

  List<String> categories = [
    "Elektronika",
    "Market",
    "Otel",
    "Transport",
  ];

  String? selectCategory;

  String? selectedDateOne;
  String? selectedDateTwo;

  List<String> list = [];

  List<int> types = [];

  formatDate(String date) {
    DateFormat('yyyy').format(HttpDate.parse(date));
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<ReceiptsController>();
  }

  @override
  void initState() {
    super.initState();
    receiptsController.getAll();
    scrollController = new ScrollController()..addListener(_scrollListener);
  }

  _scrollListener() {
    if (scrollController!.position.extentAfter <= 0 &&
        receiptsController.receiptResponse.value!.nextPageUrl != null) {
      receiptsController.page.value++;
      receiptsController.getAll();
    }
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
        title: defaultText(
          Languages.of(context)!.receipts,
          fontSize: 16.csp,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 28.w, right: 28.w, top: 40.ch),
        child: !isFilter
            ? Column(
                children: [
                  TextFormField(
                    cursorColor: CustomColors.primary,
                    decoration: InputDecoration(
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 36.ch,
                            width: 1.w,
                            color: Color(0xFFE5E5E5),
                          ),
                          SizedBox(width: 19.w),
                          GestureDetector(
                            onTap: () {
                              isFilter = true;
                              setState(() {});
                            },
                            child: Center(
                              child: SvgPicture.asset(Assets.settingsSvg),
                            ),
                          ),
                          SizedBox(width: 19.w),
                        ],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: CustomColors.border,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: CustomColors.border,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: CustomColors.primary,
                        ),
                      ),
                      hintText: Languages.of(context)!.search,
                      hintStyle: TextStyle(
                        fontSize: 16.csp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFBCB4C0),
                      ),
                      prefixIcon: IconButton(
                        splashRadius: 1,
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          Assets.searchSvg,
                          width: 18.w,
                          height: 18.w,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: !isSearch ? 20.ch : 10.ch),
                  if (isSearch) _isSearch(),
                  SizedBox(height: 20.ch),
                  Obx(() =>  Expanded(
                          child: receiptsController.loading.value
                              ? Center(child: CircularProgressIndicator.adaptive())
                              :ListView.builder(
                              controller: scrollController,
                              itemCount:
                                  receiptsController.receiptResponse.value ==
                                          null
                                      ? 0
                                      : receiptsController
                                          .receiptResponse.value!.items!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                ReceiptItem receipt =
                                receiptsController
                                    .receiptResponse.value!.items![index];
                                return _receiptItem(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ReceiptScreen(
                                                  fiscal:  receipt.id.toString(),
                                                  type: receipt.type,
                                                )));
                                  },
                                  title: receipt.name!,
                                  subTitle: receipt.fiscal?.toString(),
                                  price: receipt.sum.toString(),
                                  type: 1,
                                );
                              }),
                        )),
                  Obx(()=>receiptsController.nextPageLoading.value  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator.adaptive(),
                  )  :SizedBox())
                ],
              )
            : _filter(),
      ),
    );
  }

  Widget _receiptItem({
    required String title,
    String? subTitle,
    String? price,
    required VoidCallback onPressed,
    required int type,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
          left: 17.w,
          right: 17.w,
        ),
        margin: EdgeInsets.only(bottom: 10.ch),
        height: 74.ch,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                if (type == 1)
                  SvgPicture.asset(Assets.outlineBillSvg, width: 26.w),
                if (type == 2)
                  SvgPicture.asset(Assets.imageFillSvg, width: 26.w),
                if (type == 3)
                  SvgPicture.asset(Assets.editFillSvg, width: 26.w),
                SizedBox(width: 15.w),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultText(
                      title,
                      fontSize: 14.csp,
                      fontWeight: FontWeight.w400,
                    ),
                    if (subTitle != null) SizedBox(height: 5.ch),
                    if (subTitle != null)
                      defaultText(
                        subTitle,
                        fontSize: 12.csp,
                        fontWeight: FontWeight.w400,
                      ),
                  ],
                ),
              ],
            ),
            if (price != null)
              defaultText(
                price,
                fontWeight: FontWeight.w600,
                fontSize: 14.csp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _filter() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: CustomColors.shadow,
            blurRadius: 10,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          defaultText(
            Languages.of(context)!.selectFilters,
            fontSize: 16.csp,
          ),
          SizedBox(height: 20.ch),
          _filterCheck(
            title: Languages.of(context)!.scannedReceipts,
            check: types.contains(1),
            onTap: () {
              if (types.contains(1)) {
                types.remove(1);
              } else {
                types.add(1);
              }
              setState(() {});
            },
          ),
          SizedBox(height: 22.ch),
          _filterCheck(
            title: Languages.of(context)!.manualWithImage,
            check: types.contains(2),
            onTap: () {
              if (types.contains(2)) {
                types.remove(2);
              } else {
                types.add(2);
              }
              setState(() {});
            },
          ),
          SizedBox(height: 22.ch),
          _filterCheck(
            title: Languages.of(context)!.manualWithoutImage,
            check: types.contains(3),
            onTap: () {
              if (types.contains(3)) {
                types.remove(3);
              } else {
                types.add(3);
              }
              setState(() {});
            },
          ),
          SizedBox(height: 22.ch),
          Row(
            children: [
              Flexible(
                child: DateTimePicker(
                  controller: selectedDateOneController,
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
                  controller: selectedDateTwoController,
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
          SizedBox(height: 20.ch),
          CustomButton(
            onPressed: () {
              isFilter = false;
              isSearch = true;
              list.clear();
              if (selectedDateOne != null && selectedDateTwo != null) {
                list.add("${selectedDateOne} - ${selectedDateTwo}");
              }

              setState(() {});
            },
            text: Languages.of(context)!.confirm,
            fontSize: 16.csp,
            fontWeight: FontWeight.w600,
          )
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

  Container _isSearch() {
    return Container(
      height: list.isNotEmpty ? 50.ch : 0.ch,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return _filterChip(list[index], onPressed: () {
            list.removeAt(index);
            if (list.length == 0) {
              isSearch = false;
            }
            setState(() {});
          });
        },
      ),
    );
  }

  Container _filterChip(String title, {required VoidCallback onPressed}) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
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
}

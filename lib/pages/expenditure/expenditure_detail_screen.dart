import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/localization/languages/languages.dart';

class ExpenditureDetailScreen extends StatefulWidget {
  ExpenditureDetailScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ExpenditureDetailScreen> createState() =>
      _ExpenditureDetailScreenState();
}

class _ExpenditureDetailScreenState extends State<ExpenditureDetailScreen> {
  bool isFilter = false;
  bool isSearch = false;

  TextEditingController selectedDateOneController = TextEditingController();
  TextEditingController selectedDateTwoController = TextEditingController();

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
          widget.title,
          fontSize: 16.csp,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 28.w, right: 28.w, top: 40.ch),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _costPlanItem(
              title: "Avtomobil",
              firstPrice: "450",
              secondPrice: "560.23",
              date: "14.02.2022 - 14.03.2022",
              isDanger: true,
            ),
            SizedBox(height: 40.ch),
            defaultText(
              Languages.of(context)!.payments,
              fontSize: 14.csp,
            ),
            SizedBox(height: 20.ch),
            _mainCostItem(
              title: "Braun BT413 ütü",
              price: "196.99",
              subTitle: "Kontakt pages.home",
              onPressed: () {},
            ),
            SizedBox(height: 10.ch),
            _mainCostItem(
              title: "Philips a40 fen",
              price: "60.48",
              subTitle: "Baku Electronics",
              onPressed: () {},
            ),
            SizedBox(height: 10.ch),
            _mainCostItem(
              title: "Bosch blend 4412KL423",
              price: "86.50",
              subTitle: "Kontakt pages.home",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Container _costPlanItem({
    required String title,
    required String firstPrice,
    required String date,
    required String secondPrice,
    bool isDanger = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.ch),
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 14.ch,
        bottom: 20.ch,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: CustomColors.shadow,
            blurRadius: 4,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultText(
                    title,
                    fontSize: 14.csp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 3.ch),
                  defaultText(
                    date,
                    fontSize: 12.csp,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.textSecondary,
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: (64 - 22).ch,
                width: 1,
                color: Color(0xFFE5E5E5),
              ),
              SizedBox(
                width: 123.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: firstPrice,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.csp,
                            ),
                          ),
                          TextSpan(
                            text: ' AZN',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.csp,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 3.ch),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: secondPrice,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.csp,
                              color: !isDanger
                                  ? Color(0xFFBCB4C0)
                                  : CustomColors.red,
                            ),
                          ),
                          TextSpan(
                            text: ' AZN',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.csp,
                              color: !isDanger
                                  ? Color(0xFFBCB4C0)
                                  : CustomColors.red,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 14.ch),
          Divider(height: 0.ch),
          SizedBox(height: 14.ch),
          defaultText(
            Languages.of(context)!.subcategories,
            fontSize: 14.csp,
          ),
          SizedBox(height: 10.ch),
          defaultText(
            "Kiçik məişət texnikası",
            fontSize: 14.csp,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 10.ch),
          defaultText(
            "Böyük məişət texnikası",
            fontSize: 14.csp,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Widget _mainCostItem({
    required String title,
    required String subTitle,
    required String price,
    required VoidCallback onPressed,
  }) {
    return Flexible(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.only(
            left: 17.w,
            right: 14.w,
          ),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              defaultText(
                title,
                fontSize: 14.csp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 6.ch),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: price,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.csp,
                          ),
                        ),
                        TextSpan(
                          text: ' AZN',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.csp,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.start,
                  ),
                  defaultText(
                    subTitle,
                    color: CustomColors.textSecondary,
                    fontSize: 12.csp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

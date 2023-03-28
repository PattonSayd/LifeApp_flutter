import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/expenditure/expenditure_controller.dart';
import 'package:lifeapp/pages/expenditure/expenditure_plans_add_screen.dart';
import 'package:lifeapp/pages/my_funds/my_funds_screen.dart';
import 'package:lifeapp/pages/expenditure/expenditure_response.dart';

class ExpenditurePlansScreen extends StatefulWidget {
  ExpenditurePlansScreen({Key? key}) : super(key: key);

  @override
  State<ExpenditurePlansScreen> createState() => _ExpenditurePlansScreenState();
}

class _ExpenditurePlansScreenState extends State<ExpenditurePlansScreen> {
  final ExpenditureController controller = Get.put(ExpenditureController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                height: 220.ch,
                width: 1.sw,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF690FB7),
                      Color(0xFF770EB2),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(32.r),
                    bottomLeft: Radius.circular(32.r),
                  ),
                ),
                child: Stack(
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 24.w, right: 28.w, top: 20.ch),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(
                                    Assets.arrowLeftSvg,
                                    color: CustomColors.white,
                                  ),
                                ),
                                defaultText(
                                  Languages.of(context)!.costPlans,
                                  fontSize: 16.csp,
                                  color: CustomColors.white,
                                ),
                                SizedBox(width: 23.w),
                              ],
                            ),
                            SizedBox(height: 30.ch),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 133.w,
                                  child: defaultText(
                                    Languages.of(context)!.ongoingPlans,
                                    fontSize: 18.csp,
                                    fontWeight: FontWeight.w400,
                                    color: CustomColors.white,
                                  ),
                                ),
                                defaultText(
                                  "3",
                                  fontSize: 22.csp,
                                  color: CustomColors.white,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -0.04.sh,
                      right: -0.14.sw,
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.ellipse4Svg,
                          height: 187.w,
                          width: 187.w,
                        ),
                      ),
                    ),
                    Positioned(
                      left: -20,
                      bottom: -0.02.sh,
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.ellipse2Svg,
                          height: 102.w,
                          width: 102.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -26.ch,
                child: EaseInWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ExpenditurePlansAddScreen();
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 52.ch,
                    width: 52.ch,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(105, 15, 183, 0.24),
                          blurRadius: 15,
                          spreadRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(Assets.addSvg),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 73.ch),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  rowText(
                    text: Languages.of(context)!.ongoing,
                    suffixText: Languages.of(context)!.detailed,
                    onPressed: () {},
                  ),
                  SizedBox(height: 20.ch),
                  Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          controller.unFinishedExpenditureResponse.value != null
                              ? controller.unFinishedExpenditureResponse.value!
                                  .expenditures!.length
                              : 0,
                      itemBuilder: (context, index) {
                        return _costPlanItem(
                            expenditure: controller
                                .unFinishedExpenditureResponse
                                .value!
                                .expenditures![index]);
                      })),
                  SizedBox(height: 27.ch),
                  rowText(
                    text: "Bitmiş",
                    suffixText: "Ətraflı",
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return ContinueExpenditurePlansScreen();
                      // }));
                    },
                  ),
                  SizedBox(height: 20.ch),
                  Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                      controller.finishedExpenditureResponse.value != null
                          ? controller.finishedExpenditureResponse.value!
                          .expenditures!.length
                          : 0,
                      itemBuilder: (context, index) {
                        return _costPlanItem(
                            expenditure: controller
                                .finishedExpenditureResponse
                                .value!
                                .expenditures![index]);
                      })),
                ],
              ),
            ),
          )

          // _slidableItem(0),
        ],
      ),
    );
  }

  Container _costPlanItem({required Expenditure expenditure}) {
    String startDate = "";
    String endDate = "";

    startDate =expenditure.startDate != null ? DateFormat('yyyy.MM.dd').format(expenditure.startDate!) : "";
    endDate =expenditure.endDate != null ? DateFormat('yyyy.MM.dd').format(expenditure.endDate!) : "";

    return Container(
      height: 64.ch,
      margin: EdgeInsets.only(left: 29.w, right: 27.w, bottom: 10.ch),
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
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
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              defaultText(
                expenditure.name!,
                fontSize: 14.csp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 3.ch),
              defaultText(
                startDate + " - " + endDate,
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
                        text: expenditure.limit.toString(),
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
                        text: '',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.csp,
                          color: Color(0xFFBCB4C0),
                        ),
                      ),
                      TextSpan(
                        text: ' AZN',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.csp,
                          color: Color(0xFFBCB4C0),
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
    );
  }
}

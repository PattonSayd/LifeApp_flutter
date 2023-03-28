import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/pages/my_funds/my_funds_controller.dart';
import 'package:lifeapp/pages/targets/target_payments.dart';
import 'package:lifeapp/pages/targets/target_response.dart';
import 'package:lifeapp/pages/targets/targets_controller.dart';
import 'package:lifeapp/widgets/custom_button.dart';
import 'package:lifeapp/widgets/custom_text_field.dart';
import 'package:lifeapp/widgets/system_padding.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../localization/languages/languages.dart';
import '../my_funds/fund_response.dart';

TextEditingController sumTec = TextEditingController();

class TargetDetail extends StatefulWidget {
  const TargetDetail({Key? key, this.target}) : super(key: key);

  final Target? target;

  @override
  State<TargetDetail> createState() => _TargetDetailState();
}

class _TargetDetailState extends State<TargetDetail> {
  TargetsController targetsController = Get.find();
  double monthlyPayment = 0;

  @override
  void initState() {
    super.initState();
    targetsController.goalPayment.value = [];
    targetsController.getPayments(widget.target!.id!);
    calculateMonthlyAmount();
  }

  void calculateMonthlyAmount() {
    DateTime startDate = DateTime.parse(widget.target!.startDate!);
    DateTime endDate = DateTime.parse(widget.target!.endDate!);
    int difference = endDate.difference(startDate).inDays ~/ 30;
    print(endDate.difference(startDate).inDays);
    if (difference != 0) {
      monthlyPayment = widget.target!.sum! / difference;
    } else {
      monthlyPayment = widget.target!.sum!;
    }
  }

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
                                  widget.target!.name!,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    defaultText(
                                      widget.target!.totalSum.toString(),
                                      fontSize: 18.csp,
                                      fontWeight: FontWeight.w600,
                                      color: CustomColors.white,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    defaultText(
                                      widget.target!.sum.toString(),
                                      fontSize: 16.csp,
                                      fontWeight: FontWeight.w400,
                                      color: CustomColors.white,
                                    )
                                  ],
                                ),
                                CircularPercentIndicator(
                                  radius: 30.0,
                                  lineWidth: 6.0,
                                  animation: true,
                                  percent: (widget.target!.totalSum! /
                                      widget.target!.sum!),
                                  center: defaultText(
                                      (widget.target!.totalSum! /
                                                  widget.target!.sum! *
                                                  100)
                                              .toStringAsFixed(0) +
                                          "%",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.csp,
                                      color: Colors.white),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: CustomColors.white,
                                  backgroundColor:
                                      Color.fromRGBO(255, 255, 255, 0.06),
                                )
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
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.ch),
                    defaultText(
                      Languages.of(context)!.period,
                      fontSize: 18.csp,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.hintText,
                    ),
                    SizedBox(height: 10.ch),
                    defaultText(
                      widget.target!.startDate! +
                          " - " +
                          widget.target!.endDate!,
                      fontSize: 16.csp,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.hintText,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    defaultText(
                      Languages.of(context)!.monthlyAmount,
                      fontSize: 18.csp,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.hintText,
                    ),
                    SizedBox(height: 10.ch),
                    defaultText(
                      monthlyPayment.toStringAsFixed(2) + ' AZN',
                      fontSize: 16.csp,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.hintText,
                    ),
                    SizedBox(height: 40.ch),
                    rowText(
                        text: Languages.of(context)!.payments,
                        suffixText: Languages.of(context)!.pay,
                        isPrimary: true,
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (c) => Pay(
                                    goalId: widget.target!.id,
                                  ));
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() => ListView.builder(
                        shrinkWrap: true,
                        itemCount: targetsController.goalPayment.length,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          GoalPayment goalPayment =
                              targetsController.goalPayment[index];
                          return _mainCostItem(goalPayment);
                        }))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _mainCostItem(GoalPayment goalPayment) {
    return Container(
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
            goalPayment.sum.toString(),
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
                      text: goalPayment.sum.toString(),
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
                goalPayment.createdAt!.year.toString() +
                    '-' +
                    goalPayment.createdAt!.month.toString() +
                    '-' +
                    goalPayment.createdAt!.day.toString(),
                color: CustomColors.textSecondary,
                fontSize: 12.csp,
                fontWeight: FontWeight.w400,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Pay extends StatelessWidget {
  Pay({Key? key, this.goalId}) : super(key: key);
  final int? goalId;
  final MyFundsController myFundsController = Get.find();
  final TargetsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SystemPadding(
      child: Center(
        child: Container(
          height: 280,
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Material(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              defaultText(Languages.of(context)!.amount),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: sumTec,
                fillColor: Colors.grey.withOpacity(0.3),
                padding: EdgeInsets.symmetric(horizontal: 10),
                keyboardType: TextInputType.number,
                hint: 'Sum',
              ),
              SizedBox(
                height: 20,
              ),
              defaultText(Languages.of(context)!.selectFund),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8)),
                child: Obx(() => DropdownButton(
                      isExpanded: true,
                      items: myFundsController.myFunds.value!.funds
                          ?.map<DropdownMenuItem<String>>((Fund fund) {
                        return DropdownMenuItem<String>(
                          value: fund.id.toString(),
                          child: Text(fund.name!),
                        );
                      }).toList(),
                      hint: new Text("Select fund"),
                      value: controller.selectedFundId.value == 0
                          ? myFundsController.myFunds.value!.funds![0].id!
                              .toString()
                          : controller.selectedFundId.value.toString(),
                      onChanged: (value) {
                        controller.selectedFundId.value =
                            int.parse(value.toString());
                      },
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() => CustomButton(
                  onPressed: () async {
                    await controller.pay(double.parse(sumTec.text), goalId!,
                        controller.selectedFundId.value);
                    sumTec.text = '';
                    Navigator.pop(context);
                  },
                  loading: controller.payLoading.value,
                  width: MediaQuery.of(context).size.width,
                  text: Languages.of(context)!.pay))
            ]),
          ),
        ),
      ),
    );
  }
}

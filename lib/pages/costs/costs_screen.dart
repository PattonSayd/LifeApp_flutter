import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';

import 'package:lifeapp/constants/fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/costs/category/category_response.dart';
import 'package:lifeapp/pages/costs/cost_controller.dart';
import 'package:lifeapp/pages/costs/expenditures.dart';
import 'package:lifeapp/pages/costs/main_cost_response.dart';
import 'package:lifeapp/pages/costs/tag/tag_controller.dart';
import 'package:lifeapp/pages/costs/tag/tag_cost_items/tag_cost_items_screen.dart';
import 'package:lifeapp/pages/costs/tag/tag_costs_response.dart';

import '../quick_add/quick_add_modal.dart';
import 'category/subcategory/subcategory_costs_screen.dart';

class CostsScreen extends StatelessWidget {
  CostsScreen({Key? key}) : super(key: key);

  final CostController costController = Get.put(CostController());
  final TagController tagController = Get.put(TagController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) {
                  return QuickAddDialog();
                });
          },
          backgroundColor: CustomColors.primary,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    height: 341.ch,
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
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 45.w,
                            right: 45.w,
                            top: (31.ch),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 214.w,
                                height: 32.ch,
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 28.ch,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(7.r),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: defaultText(
                                          Languages.of(context)!.week,
                                          fontSize: 12.csp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 6.ch, bottom: 6.ch),
                                      child: Center(
                                        child: defaultText(
                                          Languages.of(context)!.month,
                                          fontSize: 12.csp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1.w,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(2.r),
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 33.w),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(7.r),
                                      ),
                                      child: Center(
                                        child: defaultText(
                                          Languages.of(context)!.year,
                                          fontSize: 12.csp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 48.ch),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _barItem(
                                    price: "322.07",
                                    date: "10 Yan",
                                    y: 54.ch,
                                  ),
                                  _barItem(
                                    price: "418.50",
                                    date: "11 Yan",
                                    y: 77.ch,
                                  ),
                                  _barItem(
                                    price: "98.03",
                                    date: "12 Yan",
                                    y: 19.ch,
                                  ),
                                  _barItem(
                                    price: "24.96",
                                    date: "13 Yan",
                                    y: 7.ch,
                                  ),
                                  _barItem(
                                    price: "369.90",
                                    date: "14 Yan",
                                    y: 62.ch,
                                  ),
                                  _barItem(
                                    price: "0.00",
                                    date: "15 Yan",
                                    y: 0.ch,
                                  ),
                                  _barItem(
                                    price: "207.42",
                                    date: "16 Yan",
                                    y: 40.ch,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 72 - 187,
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.ellipse1Svg,
                              height: 187.w,
                              width: 187.w,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
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
                  SizedBox(
                    height: 365.ch,
                  ),
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/qr-scan");
                            },
                            behavior: HitTestBehavior.translucent,
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
                                child: SvgPicture.asset(
                                  Assets.cameraSvg,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "/qr-scan-manual-add");
                            },
                            behavior: HitTestBehavior.translucent,
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
                                child: SvgPicture.asset(
                                  Assets.keyboardFillSvg,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "/pages.receipts_history");
                            },
                            behavior: HitTestBehavior.deferToChild,
                            child: Container(
                              height: 52.ch,
                              padding: EdgeInsets.only(left: 16.w, right: 16.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26.r),
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
                              child: Row(
                                children: [
                                  Center(
                                    child: SvgPicture.asset(
                                      Assets.parkOutlineBillSvg,
                                      color: CustomColors.primary,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  defaultText(
                                    Languages.of(context)!.receipts,
                                    fontSize: 16.csp,
                                    color: CustomColors.primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "/pages.vat-web-view");
                            },
                            behavior: HitTestBehavior.deferToChild,
                            child: Container(
                              height: 52.ch,
                              padding: EdgeInsets.only(left: 16.w, right: 16.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26.r),
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
                              child: Row(
                                children: [
                                  Center(
                                    child: Icon(Icons.history),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(() => costController.mainCostsShort.length != 0
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: CustomColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              rowText(
                                  text:
                                      Languages.of(context)!.mainCostDirections,
                                  suffixText: Languages.of(context)!.detailed,
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "/pages.costs-details");
                                  }),
                              Obx(() => ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      costController.mainCostsShort.length,
                                  itemBuilder: (context, index) {
                                    return _mainCostItem(
                                        cost: costController
                                            .mainCostsShort[index],
                                        context: context);
                                  }))
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            rowText(
                                text: Languages.of(context)!.mainCostDirections,
                                suffixText: Languages.of(context)!.detailed,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/pages.costs-details");
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            NoItem(
                              icon: Assets.cost,
                              title: Languages.of(context)!.youHaveNotCost,
                              text: Languages.of(context)!.youCanSeeCostDetails,
                            ),
                          ],
                        )),
                  Divider(
                    height: 40,
                  ),
                  Obx(() => tagController.tagCosts.length != 0
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: CustomColors.primary.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              rowText(
                                  text: Languages.of(context)!.costPerTag,
                                  suffixText: Languages.of(context)!.detailed,
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "/pages.costs-per-tag");
                                  }),
                              Obx(() => ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: tagController.tagCosts.length,
                                  itemBuilder: (context, index) {
                                    return _mainTagCostItem(
                                        tagCostsResponse:
                                            tagController.tagCosts[index],
                                        context: context);
                                  }))
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            rowText(
                                text: Languages.of(context)!.costPerTag,
                                suffixText: Languages.of(context)!.detailed,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/pages.costs-per-tag");
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            NoItem(
                              icon: Assets.tag,
                              title: Languages.of(context)!.youHaveNotTagCost,
                              text: Languages.of(context)!
                                  .youCanSeeTagCostDetails,
                            ),
                          ],
                        )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Color(0xFFF6F6F6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        rowText(
                          text: Languages.of(context)!.expenditurePlans,
                          suffixText: Languages.of(context)!.manage,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          isPrimary: true,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, "/pages.expenditure-plans");
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: defaultText(Languages.of(context)!.byCategory),
                        ),
                        Obx(() => (costController.expenditureResponse.value !=
                                    null &&
                                costController.expenditureResponse.value!
                                        .categoryExpenditures!.length !=
                                    0)
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    costController.expenditureResponse.value !=
                                            null
                                        ? costController.expenditureResponse
                                            .value!.categoryExpenditures!.length
                                        : 0,
                                itemBuilder: (context, index) {
                                  return _costPlanItem(
                                      expenditure: costController
                                          .expenditureResponse
                                          .value!
                                          .categoryExpenditures![index]);
                                })
                            : NoItem(
                                icon: Assets.category,
                                title: Languages.of(context)!
                                    .youHaveNotCategoryCostPlan,
                                text: Languages.of(context)!
                                    .youCanSeeCategoryCostPlanDetails,
                              )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: defaultText(Languages.of(context)!.byTag),
                        ),
                        Obx(() => (costController.expenditureResponse.value !=
                                    null &&
                                costController.expenditureResponse.value!
                                        .tagExpenditures!.length >
                                    0)
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    costController.expenditureResponse.value !=
                                            null
                                        ? costController.expenditureResponse
                                            .value!.tagExpenditures!.length
                                        : 0,
                                itemBuilder: (context, index) {
                                  return _costPlanItem(
                                      expenditure: costController
                                          .expenditureResponse
                                          .value!
                                          .tagExpenditures![index]);
                                })
                            : NoItem(
                                icon: Assets.tag,
                                title: Languages.of(context)!
                                    .youHaveNotTagCostPlan,
                                text: Languages.of(context)!
                                    .youCanSeeTagCostPlanDetails,
                              ))
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _barItem({
    required String price,
    required String date,
    double y = 0,
  }) {
    return Column(
      children: [
        defaultText(
          price,
          fontWeight: FontWeight.w600,
          fontSize: 12.csp,
          color: Colors.white,
        ),
        SizedBox(height: 7.ch),
        Container(
          width: 14.w,
          height: y,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(height: 10.ch),
        defaultText(
          date,
          fontWeight: FontWeight.w400,
          fontSize: 10.csp,
          color: Colors.white,
        )
      ],
    );
  }

  Container _costPlanItem({required Expenditure expenditure}) {
    return Container(
      height: 64.ch,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
          defaultText(
            expenditure.name!,
            fontSize: 14.csp,
            fontWeight: FontWeight.w400,
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
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _mainCostItem(
      {required CategoryResponse cost, required BuildContext context}) {
    return Container(
      height: 64.ch,
      margin: EdgeInsets.symmetric(vertical: 5),
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
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SubCategoryCostsScreen(
                    label: cost.label,
                  )));
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: defaultText(
                cost.name!,
                fontSize: 14.csp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              cost.sum!.toStringAsFixed(2),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _mainTagCostItem(
      {required TagCostsResponse tagCostsResponse,
      required BuildContext context}) {
    return Container(
      height: 64.ch,
      margin: EdgeInsets.symmetric(vertical: 5),
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
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TagCostItemsScreen(
                    tag: tagController.getById(tagCostsResponse.id!),
                  )));
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: defaultText(
                tagCostsResponse.name.toString(),
                fontSize: 14.csp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: tagCostsResponse.exitemsSumItemSum!
                              .toStringAsFixed(2),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NoItem extends StatelessWidget {
  const NoItem({Key? key, this.icon, this.text, this.title}) : super(key: key);
  final String? icon;
  final String? title;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 28, horizontal: 36),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Color(0xFFF7F7F7),
        border: Border.all(color: Color(0xFF690F53).withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            color: CustomColors.shadow,
            blurRadius: 4,
          )
        ],
      ),
      child: Column(
        children: [
          SvgPicture.asset(icon!),
          SizedBox(
            height: 24,
          ),
          defaultText(title!,
              color: Color(0xFF66566E),
              fontSize: 14,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w400),
          SizedBox(height: 6),
          defaultText(text!,
              color: Color(0xFFBCB4C0),
              fontSize: 12,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w400)
        ],
      ),
    );
  }
}

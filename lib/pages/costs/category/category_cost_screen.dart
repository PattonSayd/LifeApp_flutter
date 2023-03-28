import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/costs/category/category_controller.dart';
import 'package:lifeapp/pages/costs/category/subcategory/subcategory_costs_screen.dart';
import 'package:lifeapp/pages/costs/category/time_picker.dart';

import '../cost_controller.dart';
import '../main_cost_response.dart';
import 'category_response.dart';

class CategoryCostsScreen extends StatefulWidget {
  const CategoryCostsScreen({Key? key}) : super(key: key);

  @override
  State<CategoryCostsScreen> createState() => _CategoryCostsScreenState();
}

class _CategoryCostsScreenState extends State<CategoryCostsScreen> {
  final CostController costController = Get.put(CostController());
  final CategoryController categoryController = Get.put(CategoryController());
  DatePickerController _datePickerController = Get.put(DatePickerController());

  @override
  void dispose() {
    super.dispose();
    fromTEC.text = "";
    toTEC.text = "";
    _datePickerController.fromDate.value = "";
    _datePickerController.toDate.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
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
          Languages.of(context)!.detailedReviewOfCosts,
          fontSize: 16.csp,
        ),
      ),
      body: Column(
        children: [
          FilterDatePicker(
            onSelected: () {
              categoryController.getCategoryCosts();
            },
          ),
          Divider(
            height: 20,
          ),
          Obx(() => Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categoryController.categoryCosts.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      CategoryResponse cost =
                          categoryController.categoryCosts[index];
                      return _mainCostItem(cost: cost);
                    }),
              ))
        ],
      ),
    );
  }

  Container _mainCostItem({required CategoryResponse cost}) {
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
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SubCategoryCostsScreen(
                    label: cost.label,
                    parentId: cost.id!,
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
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: cost.sum!.toStringAsFixed(2),
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
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_right_alt,
                  color: CustomColors.primary,
                  size: 30,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

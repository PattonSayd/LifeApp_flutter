import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/pages/costs/category/subcategory/cost_items/subcategory_cost_items_screen.dart';
import 'package:lifeapp/pages/costs/category/subcategory/subcategory_cost_response.dart';
import 'package:lifeapp/pages/costs/category/subcategory/subcateogry_controller.dart';
import 'package:lifeapp/pages/costs/category/time_picker.dart';

class SubCategoryCostsScreen extends StatefulWidget {
  const SubCategoryCostsScreen({Key? key, this.label, this.parentId})
      : super(key: key);

  final String? label;
  final int? parentId;

  @override
  State<SubCategoryCostsScreen> createState() => _SubCategoryCostsScreenState();
}

class _SubCategoryCostsScreenState extends State<SubCategoryCostsScreen> {
  final SubCategoryController controller = Get.put(SubCategoryController());

  @override
  void initState() {
    super.initState();
    controller.getSubcategoryCosts(widget.parentId!);
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
          widget.label!,
          fontSize: 16.csp,
        ),
      ),
      body: Column(
        children: [
          FilterDatePicker(
            onSelected: () {
              controller.getSubcategoryCosts(widget.parentId!);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Obx(() => Expanded(
                child: controller.loading.value
                    ? Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.subCategoryCosts.length,
                        itemBuilder: (context, index) {
                          SubCategoryCostResponse cost =
                              controller.subCategoryCosts[index];
                          if (cost.childExitemsSumItemSum != 0) {
                            return _mainCostItem(category: cost);
                          } else {
                            return SizedBox();
                          }
                        }),
              ))
        ],
      ),
    );
  }

  Container _mainCostItem({required SubCategoryCostResponse category}) {
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
              builder: (context) => SubCategoryCostItemsScreen(
                    label: category.label,
                  )));
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: defaultText(
                category.name!,
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
                        text:
                            category.childExitemsSumItemSum!.toStringAsFixed(2),
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

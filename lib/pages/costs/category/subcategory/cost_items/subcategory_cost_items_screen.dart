import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/pages/costs/category/subcategory/cost_items/subcategory_cost_item_response.dart';
import 'package:lifeapp/pages/costs/category/subcategory/subcategory_cost_response.dart';
import 'package:lifeapp/pages/costs/category/subcategory/subcateogry_controller.dart';

import '../../../../receipt/receipt_screen.dart';

class SubCategoryCostItemsScreen extends StatefulWidget {
  const SubCategoryCostItemsScreen({Key? key, this.label}) : super(key: key);

  final String? label;

  @override
  State<SubCategoryCostItemsScreen> createState() =>
      _SubCategoryCostItemsScreenState();
}

class _SubCategoryCostItemsScreenState
    extends State<SubCategoryCostItemsScreen> {
  final SubCategoryController controller = Get.put(SubCategoryController());
  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    controller.page.value = 0;
    controller.getSubcategoryCostItems(widget.label!);

    scrollController = new ScrollController()..addListener(_scrollListener);
  }

  _scrollListener() {
    if (scrollController!.position.extentAfter <= 0 &&
        controller.subcategoryCostItemsResponse.value!.nextPageUrl != null) {
      controller.page.value++;
      controller.getSubcategoryCostItems(widget.label!);
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
        centerTitle: true,
        title: defaultText(
          widget.label!,
          fontSize: 16.csp,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Obx(() => Expanded(
                child: controller.subcategoryCostItemsLoading.value
                    ? Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: controller
                            .subcategoryCostItemsResponse.value!.items!.length,
                        itemBuilder: (context, index) {
                          return _mainCostItem(
                              costItem: controller.subcategoryCostItemsResponse
                                  .value!.items![index]);
                        }),
              )),
          Obx(() => controller.nextPageLoading.value
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator.adaptive(),
                )
              : SizedBox())
        ],
      ),
    );
  }

  Widget _mainCostItem({required SubCategoryCostItem costItem}) {
    return GestureDetector(
      onTap: () {
        if (costItem.checkId != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReceiptScreen(
                        fiscal: costItem.checkId!.toString(),
                        type: 'kassa',
                      )));
        }
      },
      child: Container(
        height: 84.ch,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: defaultText(
                    costItem.itemName!,
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
                            text: costItem.itemPrice!.toStringAsFixed(2),
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
                    if (costItem.checkId != null)
                      Icon(
                        Icons.arrow_right_alt,
                        color: CustomColors.primary,
                        size: 30,
                      )
                  ],
                )
              ],
            ),
            if (costItem.check != null)
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                        child: defaultText(costItem.check!.companyName!,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.grey2,
                            overflow: TextOverflow.ellipsis)),
                    VerticalDivider(
                      width: 20,
                      thickness: 1,
                    ),
                    Expanded(
                        child: defaultText(costItem.check!.storeName!,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.grey2,
                            overflow: TextOverflow.ellipsis)),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

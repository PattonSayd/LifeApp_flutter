import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifeapp/pages/costs/category/time_picker.dart';
import 'package:lifeapp/pages/costs/tag/tag_cost_items/tag_cost_items_controller.dart';
import 'package:lifeapp/pages/costs/tag/tag_cost_items/tag_cost_items_response.dart';
import 'package:lifeapp/pages/costs/tag/tag_response_dto.dart';

class TagCostItemsScreen extends StatefulWidget {
  const TagCostItemsScreen({Key? key, this.tag}) : super(key: key);

  final Tag? tag;

  @override
  State<TagCostItemsScreen> createState() => _TagCostItemsScreenState();
}

class _TagCostItemsScreenState extends State<TagCostItemsScreen> {
  final TagCostItemsController controller = Get.put(TagCostItemsController());
  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    controller.page.value = 0;
    controller.getTagCostItems(widget.tag!.id!);

    scrollController = new ScrollController()..addListener(_scrollListener);
  }

  _scrollListener() {
    if (scrollController!.position.extentAfter <= 0 &&
        controller.tagCostItemsResponse.value!.nextPageUrl != null) {
      controller.page.value++;
      controller.getTagCostItems(widget.tag!.id!);
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
          widget.tag!.name!,
          fontSize: 16.csp,
        ),
      ),
      body: Column(
        children: [
          FilterDatePicker(
            onSelected: () {
              controller.getTagCostItems(widget.tag!.id!);
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
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: controller
                            .tagCostItemsResponse.value!.items!.length,
                        itemBuilder: (context, index) {
                          return _mainCostItem(
                              costItem: controller
                                  .tagCostItemsResponse.value!.items![index]);
                        }),
              ))
        ],
      ),
    );
  }

  Container _mainCostItem({required TagCostItem costItem}) {
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
            ],
          )
        ],
      ),
    );
  }
}

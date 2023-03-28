import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/package/flutter_slidable/flutter_slidable.dart';
import 'package:lifeapp/pages/costs/category/time_picker.dart';
import 'package:lifeapp/pages/costs/tag/tag_controller.dart';
import 'package:lifeapp/pages/costs/tag/tag_cost_items/tag_cost_items_screen.dart';
import 'package:lifeapp/pages/costs/tag/tag_costs_response.dart';
import 'package:lifeapp/pages/costs/tag/tag_response_dto.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../localization/languages/languages.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/system_padding.dart';

final TextEditingController nameTEC = TextEditingController();
final TextEditingController commentTEC = TextEditingController();

class TagScreen extends StatefulWidget {
  const TagScreen({Key? key}) : super(key: key);

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  final TagController tagController = Get.put(TagController());
  DatePickerController _datePickerController = Get.put(DatePickerController());

  @override
  void dispose() {
    super.dispose();
    Get.delete<TagController>();
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
      body: Padding(
          padding: EdgeInsets.only(left: 28.w, right: 28.w, top: 20.ch),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultText(
                        Languages.of(context)!.byTag,
                        fontSize: 18.csp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  CustomButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AddTag();
                          });
                    },
                    text: Languages.of(context)!.add,
                    fontSize: 14.csp,
                    fontWeight: FontWeight.w600,
                    padding: EdgeInsets.symmetric(
                      horizontal: 19.w,
                      vertical: 10.ch,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.ch),
              FilterDatePicker(onSelected: (){
                tagController.getAllTagCosts();
              }),
              SizedBox(height: 20.ch),
              Expanded(
                child: Obx(() => tagController.loading.value
                    ? Center(child: CircularProgressIndicator.adaptive())
                    : ListView.builder(
                        itemCount: tagController.tagCosts.length,
                        itemBuilder: (context, index) {
                          return _mainCostItem(
                              tagCost: tagController.tagCosts[index],
                              index: index);
                        })),
              ),
            ],
          )),
    );
  }

  Widget _mainCostItem(
      {required TagCostsResponse tagCost, required int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Slidable(
        endActionPane: ActionPane(
          dragDismissible: false,
          extentRatio: 0.19,
          motion: BehindMotion(),
          children: [
            SlidableAction(
              flex: 2,
              onPressed: (BuildContext context) {
                tagController.delete(index);
              },
              backgroundColor: CustomColors.red,
              foregroundColor: Colors.white,
              svg: SvgPicture.asset(Assets.deleteSvg),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Tag tag = tagController.getById(tagCost.id!);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TagCostItemsScreen(
                      tag: tag,
                    )));
          },
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                defaultText(
                  tagCost.name!,
                  fontSize: 14.csp,
                  fontWeight: FontWeight.w400,
                ),
                Row(
                  children: [
                    defaultText(
                      tagCost.exitemsSumItemSum!.toStringAsFixed(2) + ' AZN',
                      fontSize: 14.csp,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(width: 10,),
                    GestureDetector(
                        onTap: () {
                          nameTEC.text = tagCost.name!;
                          commentTEC.text = tagCost.comment ?? '';
                          Tag tag = tagController.getById(tagCost.id!);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return EditTag(
                                  tag: tag,
                                  index: index,
                                );
                              });
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Icon(Icons.edit ,color: CustomColors.primary,))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddTag extends StatelessWidget {
  AddTag({Key? key}) : super(key: key);

  final TagController tagController = Get.put(TagController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SystemPadding(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 250,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: nameTEC,
                    hint: Languages.of(context)!.enterName,
                    hasBorder: true,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: commentTEC,
                    hint: Languages.of(context)!.comment,
                    hasBorder: true,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() => CustomButton(
                      onPressed: () async {
                        await tagController.create(
                            nameTEC.text.trim(), commentTEC.text.trim());
                        nameTEC.text = "";
                        commentTEC.text = "";
                        Navigator.pop(context);
                      },
                      width: MediaQuery.of(context).size.width,
                      loading: tagController.saveLoading.value,
                      text: Languages.of(context)!.save))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditTag extends StatelessWidget {
  EditTag({Key? key, this.tag, this.index}) : super(key: key);
  final Tag? tag;
  final int? index;
  final TagController tagController = Get.put(TagController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SystemPadding(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 250,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: nameTEC,
                    hint: Languages.of(context)!.enterName,
                    hasBorder: true,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: commentTEC,
                    hint: Languages.of(context)!.comment,
                    hasBorder: true,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          child: Obx(() => CustomButton(
                              onPressed: () async {
                                await tagController.delete(index!);
                                nameTEC.text = "";
                                commentTEC.text = "";
                                Navigator.pop(context);
                              },
                              backgroundColor: CustomColors.red,
                              outlineColor: CustomColors.red,
                              width: MediaQuery.of(context).size.width,
                              loading: tagController.deleteLoading.value,
                              text: Languages.of(context)!.delete))),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          fit: FlexFit.tight,
                          child: Obx(() => CustomButton(
                              onPressed: () async {
                                await tagController.edit(nameTEC.text.trim(),
                                    commentTEC.text.trim(), tag!.id!);
                                nameTEC.text = "";
                                commentTEC.text = "";
                                Navigator.pop(context);
                              },
                              width: MediaQuery.of(context).size.width,
                              loading: tagController.saveLoading.value,
                              text: Languages.of(context)!.save)))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

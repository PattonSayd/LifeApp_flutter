import 'package:barcode/barcode.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/costs/category/category_controller.dart';
import 'package:lifeapp/pages/costs/category/category_response.dart';
import 'package:lifeapp/pages/costs/cost_controller.dart';
import 'package:lifeapp/pages/costs/tag/tag_controller.dart';
import 'package:lifeapp/pages/costs/tag/tag_response_dto.dart';
import 'package:lifeapp/pages/receipt/receipt.dart';
import 'package:lifeapp/pages/receipt/receipt_controller.dart';
import 'package:lifeapp/widgets/custom_button.dart';

import '../../widgets/system_padding.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({Key? key, this.fiscal, this.type}) : super(key: key);

  final String? fiscal;
  final String? type;

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  final ReceiptController receiptController = Get.put(ReceiptController());
  TagController tagController = Get.put(TagController());

  @override
  void initState() {
    super.initState();
    receiptController.getReceipt(widget.fiscal!, widget.type!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 6,
            shadowColor: CustomColors.primary.withOpacity(0.08),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: SvgPicture.asset(
                  Assets.closeSvg,
                  width: 24.w,
                  height: 24.w,
                ),
              ),
            ),
          ),
          body: Obx(() => receiptController.loading.value
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (widget.type == "kassa")
                          AutomaticReceiptItemsHeader(),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            defaultText(Languages.of(context)!.productName),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 50.w,
                                  child: defaultText(
                                    Languages.of(context)!.count,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  width: 50.w,
                                  child: defaultText(
                                    Languages.of(context)!.price,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  width: 50.w,
                                  child: defaultText(
                                    Languages.of(context)!.total,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.ch),
                        Divider(
                          thickness: 1,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: receiptController
                                .receipt.value!.exitems!.length,
                            itemBuilder: (context, index) {
                              ReceiptItem receipt = receiptController
                                  .receipt.value!.exitems![index];
                              return ReceiptItemView(
                                receipt: receipt,
                                index: index,
                              );
                            }),
                        if (widget.type == "kassa")
                          AutomaticReceiptItemsFooter()
                      ],
                    ),
                  ),
                )),
        ),
      ),
    );
  }
}

class AutomaticReceiptItemsHeader extends StatelessWidget {
  AutomaticReceiptItemsHeader({Key? key}) : super(key: key);
  final ReceiptController receiptController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: defaultText(
              Languages.of(context)!.tsName +
                  receiptController.receipt.value!.check!.storeName!,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              color: CustomColors.textBlack,
              fontSize: 12,
              height: 1.5),
        ),
        Center(
          child: defaultText(
              Languages.of(context)!.tsAddress +
                  receiptController.receipt.value!.check!.storeAddress!,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w300,
              color: CustomColors.textColorLight,
              fontSize: 12,
              height: 1.5),
        ),
        Center(
          child: defaultText(
              Languages.of(context)!.veenName +
                  receiptController.receipt.value!.check!.companyName!,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w300,
              color: CustomColors.textColorLight,
              fontSize: 12,
              height: 1.5),
        ),
        Center(
          child: defaultText(
              Languages.of(context)!.veen +
                  receiptController.receipt.value!.check!.companyTaxNumber!,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w300,
              color: CustomColors.textColorLight,
              fontSize: 12,
              height: 1.5),
        ),
        Center(
          child: defaultText(
              Languages.of(context)!.objectCode +
                  receiptController.receipt.value!.check!.storeTaxNumber!,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w300,
              color: CustomColors.textColorLight,
              fontSize: 12,
              height: 1.5),
        ),
        SizedBox(
          height: 10,
        ),
        defaultText(
            Languages.of(context)!.cashier +
                receiptController.receipt.value!.check!.cashier!,
            fontWeight: FontWeight.w300,
            color: CustomColors.blackSecondary,
            fontSize: 12,
            height: 1.5),
        defaultText(
            Languages.of(context)!.date +
                receiptController.receipt.value!.check!.checkDate.toString(),
            fontWeight: FontWeight.w300,
            color: CustomColors.textColorLight,
            fontSize: 12,
            height: 1.5),
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}

class AutomaticReceiptItemsFooter extends StatelessWidget {
  AutomaticReceiptItemsFooter({Key? key}) : super(key: key);
  final ReceiptController receiptController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultText(
            Languages.of(context)!.checkCountDuringDay +
                receiptController.receipt.value!.check!.storeTaxNumber!,
            fontWeight: FontWeight.w300,
            color: CustomColors.textColorLight,
            fontSize: 12,
            height: 1.5),
        defaultText(
            Languages.of(context)!.cashRegisterModel +
                receiptController.receipt.value!.check!.cashRegisterModelName!,
            fontWeight: FontWeight.w300,
            color: CustomColors.textColorLight,
            fontSize: 12,
            height: 1.5),
        defaultText(
            Languages.of(context)!.cashRegisterFactoryNumber +
                receiptController
                    .receipt.value!.check!.cashRegisterFactoryNumber!,
            fontWeight: FontWeight.w300,
            color: CustomColors.textColorLight,
            fontSize: 12,
            height: 1.5),
        defaultText(
            Languages.of(context)!.fiscalId +
                receiptController.receipt.value!.check!.fiscal.toString(),
            fontWeight: FontWeight.w300,
            color: CustomColors.textColorLight,
            fontSize: 12,
            height: 1.5),
        defaultText(
            Languages.of(context)!.NMQRegistrationNumber +
                receiptController.receipt.value!.check!.cashBoxTaxNumber!,
            fontWeight: FontWeight.w300,
            color: CustomColors.textColorLight,
            fontSize: 12,
            height: 1.5),
        SizedBox(
          height: 20,
        ),
        Center(
          child: SvgPicture.string(Barcode.qrCode().toSvg(
              "https://monitoring.e-kassa.gov.az/#/index?doc=" +
                  receiptController.receipt.value!.check!.fiscal.toString(),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4)),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class ReceiptItemView extends StatelessWidget {
  ReceiptItemView({Key? key, this.receipt, this.index}) : super(key: key);

  final ReceiptItem? receipt;
  final TagController tagController = Get.find();
  final ReceiptController receiptController = Get.find();
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Row(
                  children: [
                    Flexible(
                      child: defaultText(receipt!.itemName!,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.left),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 50.w,
                    child: defaultText(
                      receipt!.itemCount!.toString(),
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                    child: defaultText(
                      receipt!.itemPrice!.toString(),
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                    child: defaultText(
                      receipt!.itemSum!.toString(),
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 5.ch),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SelectTag(
                          receiptItemIndex: index,
                        );
                      });
                },
                text: receipt!.tag == null
                    ? "#add tag"
                    : "#" + receipt!.tag!.name!,
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.black,
                height: 30,
                backgroundColor: Colors.transparent,
                outlineColor: Colors.grey,
              ),
              GestureDetector(
                onTap: () {
                  if (receipt!.probability! < 0.8) {
                    receiptController.isSubCategoryScreen.value = false;
                    receiptController.subCategories.value = [];
                    receiptController.subCategories.refresh();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SelectCategory(
                            receiptItemIndex: index,
                          );
                        });
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: defaultText(
                              receipt!.mlCategoryId.toString(),
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w400,
                              color: CustomColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 7.w),
                    if (receipt!.probability! < 0.8)
                      SvgPicture.asset(
                        Assets.arrowDownSvg,
                        width: 6.ch,
                        height: 6.ch,
                        fit: BoxFit.cover,
                        color: receipt!.probability! < 0.5
                            ? Colors.red
                            : Colors.yellow,
                      ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 5.ch),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class SelectTag extends StatelessWidget {
  SelectTag({Key? key, this.receiptItemIndex}) : super(key: key);
  final TagController tagController = Get.put(TagController());
  final ReceiptController receiptController = Get.find();
  final int? receiptItemIndex;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SystemPadding(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 450,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    defaultText(Languages.of(context)!.selectTag,
                        fontWeight: FontWeight.w500, fontSize: 18),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/pages.costs-per-tag");
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Icon(Icons.add),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() => Expanded(
                      child: ListView.builder(
                          itemCount:
                              tagController.tagResponse.value!.tags!.length,
                          itemBuilder: (context, index) {
                            Tag tag =
                                tagController.tagResponse.value!.tags![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Obx(() => CustomButton(
                                  onPressed: () async {
                                    await receiptController.addTagToReceiptItem(
                                        receiptItemIndex!, tag);
                                    Navigator.pop(context);
                                  },
                                  loading:
                                      receiptController.loadingTagId == tag.id!,
                                  text: tag.name!)),
                            );
                          }),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectCategory extends StatelessWidget {
  SelectCategory({Key? key, this.receiptItemIndex}) : super(key: key);
  final CategoryController categoryController = Get.put(CategoryController());
  final ReceiptController receiptController = Get.find();
  final int? receiptItemIndex;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SystemPadding(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 450,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!receiptController.isSubCategoryScreen.value) {
                          Navigator.pop(context);
                        } else {
                          receiptController.isSubCategoryScreen.value = false;
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Icon(Icons.keyboard_arrow_left),
                    ),
                    Obx(() => defaultText(
                        !receiptController.isSubCategoryScreen.value
                            ? Languages.of(context)!.selectCategory
                            : Languages.of(context)!.selectSubCategory,
                        fontWeight: FontWeight.w500,
                        fontSize: 18)),
                    SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() => !receiptController.isSubCategoryScreen.value
                    ? Obx(() => Expanded(
                          child: ListView.builder(
                              itemCount: categoryController.categories.length,
                              itemBuilder: (context, index) {
                                CategoryResponse category =
                                    categoryController.categories[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Obx(() => CustomButton(
                                      onPressed: () async {
                                        receiptController
                                            .getSubCategories(category.label!);
                                      },
                                      loading:
                                          receiptController.loadingCategoryId ==
                                              category.id!,
                                      text: category.name!)),
                                );
                              }),
                        ))
                    : Obx(() => Expanded(
                          child: receiptController.subCategoryLoading.value
                              ? Center(
                                  child: CircularProgressIndicator.adaptive())
                              : ListView.builder(
                                  itemCount:
                                      receiptController.subCategories.length,
                                  itemBuilder: (context, index) {
                                    CategoryResponse category =
                                        receiptController.subCategories[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Obx(() => CustomButton(
                                          onPressed: () async {
                                            await receiptController
                                                .changeCategory(
                                                    receiptItemIndex!,
                                                    category);
                                            Navigator.pop(context);
                                          },
                                          loading: receiptController
                                                  .loadingCategoryId ==
                                              category.id!,
                                          text: category.name!)),
                                    );
                                  }),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

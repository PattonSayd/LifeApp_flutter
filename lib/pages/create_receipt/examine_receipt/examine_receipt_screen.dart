import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/pages/create_receipt/result/result_screen.dart';
import 'package:lifeapp/utils/round_double.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/fonts.dart';
import '../../../../../localization/languages/languages.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../../../../widgets/system_padding.dart';
import '../../costs/category/category_response.dart';
import '../../costs/tag/tag_response_dto.dart';
import 'examine_receipt_controller.dart';
import 'models/product.dart';

class ExamineReceipt extends StatefulWidget {
  const ExamineReceipt({Key? key, this.fiscal, this.base64}) : super(key: key);

  final String? fiscal;
  final String? base64;

  @override
  State<ExamineReceipt> createState() => _ExamineReceiptState();
}

class _ExamineReceiptState extends State<ExamineReceipt> {
  final ExamineReceiptController examineReceiptController =
      Get.put(ExamineReceiptController());
  File? file;

  @override
  void initState() {
    super.initState();
    _getReceipt();
  }

  void _getReceipt() async {
    File file = await _createFileFromString();
    examineReceiptController.getReceipt(file, widget.fiscal!);
  }

  Future<File> _createFileFromString() async {
    String base64 = widget.base64!.substring(23);
    final bytes = base64Decode(base64);
    String dir = (await getApplicationDocumentsDirectory()).path;
    file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
    await file!.writeAsBytes(bytes);
    return file!;
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<ExamineReceiptController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: defaultText(widget.fiscal!, color: Colors.white, fontSize: 16),
        centerTitle: true,
        backgroundColor: CustomColors.primary,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateReceiptResultScreen(
                                products: examineReceiptController.products,
                                saveReceipt:
                                    examineReceiptController.saveReceiptModel,
                              )));
                },
                width: MediaQuery.of(context).size.width,
                text: Languages.of(context)!.save)
          ],
        ),
      ),
      body: Obx(() => examineReceiptController.loading.value
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: defaultText('Ad',
                              fontSize: 14, fontWeight: FontWeight.w600)),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: defaultText('Say',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center)),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: defaultText('Qiymət',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center)),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: defaultText('Cəmi',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Obx(() => ListView.builder(
                          itemCount: examineReceiptController.products.length,
                          itemBuilder: (context, index) {
                            return ReceiptItem(
                              product: examineReceiptController.products[index],
                              index: index,
                            );
                          },
                        )),
                  )
                ],
              ),
            )),
    );
  }
}

class ReceiptItem extends StatelessWidget {
  ReceiptItem({Key? key, this.product, this.index}) : super(key: key);
  final Product? product;
  final int? index;
  final ExamineReceiptController examineReceiptController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: (product!.count! * product!.price!).roundToPrecision(2) !=
                  product!.sum!.roundToPrecision(2)
              ? const Color(0xFFfec901)
              : Colors.white,
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      examineReceiptController.inputOpen[index!]['name'] =
                          !examineReceiptController.inputOpen[index!]['name']!;
                      examineReceiptController.inputOpen.refresh();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Obx(() => examineReceiptController.inputOpen[index!]
                            ['name']!
                        ? CustomTextField(
                            onFieldSubmitted: (value) {
                              product!.name = value;
                              examineReceiptController.inputOpen[index!]
                                  ['name'] = false;
                              examineReceiptController.inputOpen.refresh();
                            },
                            textInputAction: TextInputAction.done,
                            controller:
                                TextEditingController(text: product!.name!),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                          )
                        : defaultText(product!.name!,
                            fontSize: 12, fontWeight: FontWeight.w400)),
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      examineReceiptController.inputOpen[index!]['count'] =
                          !examineReceiptController.inputOpen[index!]['count']!;
                      examineReceiptController.inputOpen.refresh();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Obx(() => examineReceiptController.inputOpen[index!]
                            ['count']!
                        ? CustomTextField(
                            onFieldSubmitted: (value) {
                              product!.count = double.parse(value);
                              examineReceiptController.inputOpen[index!]
                                  ['count'] = false;
                              examineReceiptController.inputOpen.refresh();
                            },
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(
                                text: product!.count!.toString()),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                          )
                        : defaultText(product!.count.toString(),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.center)),
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      examineReceiptController.inputOpen[index!]['price'] =
                          !examineReceiptController.inputOpen[index!]['price']!;
                      examineReceiptController.inputOpen.refresh();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Obx(() => examineReceiptController.inputOpen[index!]
                            ['price']!
                        ? CustomTextField(
                            onFieldSubmitted: (value) {
                              product!.price = double.parse(value);
                              examineReceiptController.inputOpen[index!]
                                  ['price'] = false;
                              examineReceiptController.inputOpen.refresh();
                            },
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(
                                text: product!.price!.toString()),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                          )
                        : defaultText(product!.price.toString(),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.center)),
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      examineReceiptController.inputOpen[index!]['sum'] =
                          !examineReceiptController.inputOpen[index!]['sum']!;
                      examineReceiptController.inputOpen.refresh();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Obx(() => examineReceiptController.inputOpen[index!]
                            ['sum']!
                        ? CustomTextField(
                            onFieldSubmitted: (value) {
                              product!.sum = double.parse(value);
                              examineReceiptController.inputOpen[index!]
                                  ['sum'] = false;
                              examineReceiptController.inputOpen.refresh();
                            },
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(
                                text: product!.sum!.toString()),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                          )
                        : defaultText(product!.sum.toString(),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.center)),
                  )),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                text: product!.tag == null ? "#add tag" : "#" + product!.tag!,
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.black,
                height: 30,
                backgroundColor: Colors.transparent,
                outlineColor: Colors.grey,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SelectCategory(
                          receiptItemIndex: index,
                        );
                      });
                },
                behavior: HitTestBehavior.opaque,
                child: defaultText(product!.category!,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.primary),
              )
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}

class SelectTag extends StatelessWidget {
  SelectTag({Key? key, this.receiptItemIndex}) : super(key: key);
  final ExamineReceiptController examineReceiptController = Get.find();
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
                              examineReceiptController.tagResponse.value != null
                                  ? examineReceiptController
                                      .tagResponse.value!.tags?.length
                                  : 0,
                          itemBuilder: (context, index) {
                            Tag tag = examineReceiptController
                                .tagResponse.value!.tags![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Obx(() => CustomButton(
                                  onPressed: () async {
                                    examineReceiptController
                                        .products[receiptItemIndex!]
                                        .tagId = tag.id;
                                    examineReceiptController
                                        .products[receiptItemIndex!]
                                        .tag = tag.name;
                                    examineReceiptController.products.refresh();
                                    Navigator.pop(context);
                                  },
                                  loading:
                                      examineReceiptController.loadingTagId ==
                                          tag.id!,
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
  final ExamineReceiptController examineReceiptController = Get.find();
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
                        if (!examineReceiptController
                            .isSubCategoryScreen.value) {
                          Navigator.pop(context);
                        } else {
                          examineReceiptController.isSubCategoryScreen.value =
                              false;
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Icon(Icons.keyboard_arrow_left),
                    ),
                    Obx(() => defaultText(
                        !examineReceiptController.isSubCategoryScreen.value
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
                Obx(() => !examineReceiptController.isSubCategoryScreen.value
                    ? Obx(() => Expanded(
                          child: ListView.builder(
                              itemCount:
                                  examineReceiptController.categories.length,
                              itemBuilder: (context, index) {
                                CategoryResponse category =
                                    examineReceiptController.categories[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Obx(() => CustomButton(
                                      onPressed: () async {
                                        examineReceiptController
                                            .getSubCategories(category.label!);
                                        examineReceiptController
                                            .products[receiptItemIndex!]
                                            .categoryId = category.id!;
                                      },
                                      loading: examineReceiptController
                                              .loadingCategoryId ==
                                          category.id!,
                                      text: category.name!)),
                                );
                              }),
                        ))
                    : Obx(() => Expanded(
                          child: examineReceiptController
                                  .subCategoryLoading.value
                              ? Center(
                                  child: CircularProgressIndicator.adaptive())
                              : ListView.builder(
                                  itemCount: examineReceiptController
                                      .subCategories.length,
                                  itemBuilder: (context, index) {
                                    CategoryResponse category =
                                        examineReceiptController
                                            .subCategories[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Obx(() => CustomButton(
                                          onPressed: () async {
                                            examineReceiptController
                                                .products[receiptItemIndex!]
                                                .subCategoryId = category.id!;
                                            examineReceiptController
                                                .products[receiptItemIndex!]
                                                .category = category.label!;
                                            examineReceiptController.products
                                                .refresh();
                                            Navigator.pop(context);
                                            examineReceiptController
                                                .isSubCategoryScreen
                                                .value = false;
                                          },
                                          loading: examineReceiptController
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

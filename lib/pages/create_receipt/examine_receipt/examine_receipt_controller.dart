import 'dart:io';

import 'package:get/get.dart';
import 'package:lifeapp/utils/replace_dot_place_at_double.dart';
import 'package:lifeapp/utils/string_datetime_fomrat.dart';

import '../../../../../core/network/Response.dart';
import '../../costs/category/category_response.dart';
import '../../costs/category/category_service.dart';
import '../../costs/category/subcategory/sub_category_service.dart';
import '../../costs/tag/tag_response_dto.dart';
import '../../costs/tag/tag_service.dart';
import 'models/categories.dart';
import 'examine_receipt_service.dart';
import 'models/product.dart';
import 'models/receipt_text.dart';
import 'models/save_receipt.dart';

class ExamineReceiptController extends GetxController {
  final ExamineReceiptService examineReceiptService = ExamineReceiptService();
  final CategoryService categoryService = CategoryService();
  final SubCategoryService subCategoryService = SubCategoryService();
  final TagService tagService = TagService();
  RxBool loading = true.obs;
  RxList<Product> products = RxList();
  SaveReceipt saveReceiptModel = SaveReceipt();
  RxList<Map<String, bool>> inputOpen = RxList();
  RxList<CategoryResponse> categories = RxList();
  RxList<CategoryResponse> subCategories = RxList();
  Rxn<TagResponseDto> tagResponse = Rxn();
  RxBool subCategoryLoading = false.obs;
  RxBool isSubCategoryScreen = false.obs;
  RxInt loadingCategoryId = 0.obs;
  RxInt loadingTagId = 0.obs;

  void getReceipt(File file, String fiscal) async {
    loading.value = true;
    ReceiptText receiptText = await examineReceiptService.getReceipt(file);
    String result = receiptText.fullText![0];
    List<String> receiptValues = result.split('\n');
    RegExp itemRegex = RegExp(
        r'(.+)\s([+-]?[0-9]*[.]?[0-9]+)\s([+-]?[0-9]*[.]?[0-9]+)\s([+-]?[0-9]*[.]?[0-9]+)');
    String receiptInfo = '';
    bool collectReceiptInfo = true;
    for (String item in receiptValues) {
      if (item.contains('Satış çeki')) {
        collectReceiptInfo = false;
      }
      if (collectReceiptInfo) {
        receiptInfo += item;
      }
      if (itemRegex.hasMatch(item)) {
        var match = itemRegex.firstMatch(item);
        if (match != null) {
          String name = match.group(1)!;
          String count = match.group(2)!;
          String price = match.group(3)!.replaceDotPlace(2);
          String sum = match.group(4)!.replaceDotPlace(2);
          Product product = Product(
              name: name,
              count: double.parse(count),
              price: double.parse(price),
              sum: double.parse(sum));
          products.add(product);
        }
      }
    }
    receiptInfo =
        receiptInfo.replaceAll(RegExp(r'\s|:|"|-'), '').replaceAll('.', '');
    saveReceiptModel.signature = receiptInfo;
    await getProductCategories();

    RegExp dateRegex = RegExp(r'(\d{2}\.\d{2}\.\d{4})');
    String date = dateRegex.firstMatch(result)!.group(0)!;

    RegExp timeRegex = RegExp(r'(\d{2}\:\d{2}\:\d{2})');
    String time = timeRegex.firstMatch(result)!.group(0)!;

    saveReceiptModel.date =
        date.formatDateTime('dd.MM.yyyy', 'yyyy-MM-dd') + ' ' + time;
    saveReceiptModel.fiscal = fiscal;
  }

  Future<void> getProductCategories() async {
    List<String> names = [];
    for (Product product in products) {
      names.add(product.name!);
      inputOpen
          .add({'name': false, 'count': false, 'price': false, 'sum': false});
    }
    Categories categories = await examineReceiptService.getCategories(names);
    for (int i = 0; i < categories.classificationResults!.length; i++) {
      products[i].category = categories.classificationResults![i].categoryName;
      products[i].categoryId =
          categories.classificationResults![i].categoryIdx;
      products[i].probability =
          categories.classificationResults![i].probability;
    }
    products.refresh();
    loading.value = false;
  }

  void getTags() async {
    CustomResponse customResponse = await tagService.getAll();
    if (customResponse.status == Status.COMPLETED) {
      tagResponse.value = customResponse.data;
    }
  }

  void getCategories() async {
    CustomResponse customResponse = await categoryService.getCategories();
    if (customResponse.status == Status.COMPLETED) {
      categories.value = customResponse.data;
      categories.refresh();
    }
  }

  void getSubCategories(String label) async {
    isSubCategoryScreen.value = true;
    subCategoryLoading.value = true;
    CustomResponse customResponse =
        await subCategoryService.getSubCategories(label);
    subCategoryLoading.value = false;

    if (customResponse.status == Status.COMPLETED) {
      subCategories.value = customResponse.data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCategories();
    getTags();
  }
}

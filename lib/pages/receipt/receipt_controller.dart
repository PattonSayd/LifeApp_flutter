import 'package:get/get.dart';
import 'package:lifeapp/pages/costs/category/category_response.dart';
import 'package:lifeapp/pages/costs/category/subcategory/subcategory_cost_response.dart';
import 'package:lifeapp/pages/receipt/receipt.dart';
import 'package:lifeapp/pages/receipt/receipt_service.dart';
import 'package:lifeapp/core/network/Response.dart';

import '../costs/category/subcategory/sub_category_service.dart';
import '../costs/tag/tag_response_dto.dart';

class ReceiptController extends GetxController {
  final ReceiptService receiptService = ReceiptService();
  final SubCategoryService categoryService = SubCategoryService();

  RxBool loading = false.obs;
  RxBool success = false.obs;
  Rxn<Receipt> receipt = new Rxn();
  RxInt loadingTagId = 0.obs;
  RxInt loadingCategoryId = 0.obs;
  RxList<CategoryResponse> subCategories = RxList();
  RxBool subCategoryLoading = false.obs;
  RxBool isSubCategoryScreen = false.obs;

  void getReceipt(String fiscal, String type) async {
    loading.value = true;
    CustomResponse apiResponse = await receiptService.getReceipt(fiscal);
    loading.value = false;

    if (apiResponse.status == Status.COMPLETED) {
      receipt.value = apiResponse.data;
    }
  }

  Future<void> addTagToReceiptItem(int index, Tag tag) async {
    loadingTagId.value = tag.id!;
    CustomResponse apiResponse = await receiptService.addTagToReceiptItem(
        receipt.value!.exitems![index].id!, tag.id!);
    loadingTagId.value = 0;

    TagData tagData =
        new TagData(id: tag.id, name: tag.name, comment: tag.comment);

    receipt.value!.exitems![index].tag = tagData;
    receipt.refresh();
  }

  Future<void> changeCategory(int index, CategoryResponse category) async {
    loadingCategoryId.value = category.id!;
    CustomResponse apiResponse = await receiptService.changeCategory(
        receipt.value!.exitems![index].id!, category.label!);
    loadingCategoryId.value = 0;
    //receipt.value!.exitems![index].mlCategoryId = category.name;
    receipt.refresh();
  }

  void getSubCategories(String label) async {
    isSubCategoryScreen.value = true;
    subCategoryLoading.value = true;
    CustomResponse customResponse =
        await categoryService.getSubCategories(label);
    subCategoryLoading.value = false;

    if (customResponse.status == Status.COMPLETED) {
      subCategories.value = customResponse.data;
    }
  }
}

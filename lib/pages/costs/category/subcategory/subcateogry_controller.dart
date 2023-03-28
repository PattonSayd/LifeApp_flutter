import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/costs/category/category_response.dart';
import 'package:lifeapp/pages/costs/category/subcategory/cost_items/subcategory_cost_item_response.dart';
import 'package:lifeapp/pages/costs/category/subcategory/sub_category_service.dart';
import 'package:lifeapp/pages/costs/category/subcategory/subcategory_cost_response.dart';

import '../time_picker.dart';

class SubCategoryController extends GetxController {
  final SubCategoryService categoryService = SubCategoryService();
  RxList<CategoryResponse> subCategories = RxList();
  RxList<SubCategoryCostResponse> subCategoryCosts = RxList();
  Rxn<SubCategoryCostItemResponse> subcategoryCostItemsResponse = Rxn();
  DatePickerController _datePickerController = Get.put(DatePickerController());
  RxBool loading = false.obs;
  RxBool nextPageLoading = false.obs;
  RxBool subcategoryCostItemsLoading = false.obs;
  RxInt page = 0.obs;

  void getSubcategories(String label) async {
    loading.value = true;
    CustomResponse customResponse =
        await categoryService.getSubCategories(label);
    loading.value = false;

    if (customResponse.status == Status.COMPLETED) {
      subCategories.value = customResponse.data;
    }
  }

  void getSubcategoryCosts(int label) async {
    loading.value = true;
    CustomResponse customResponse =
        await categoryService.getSubCategoryCosts(label);
    loading.value = false;

    if (customResponse.status == Status.COMPLETED) {
      subCategoryCosts.value = customResponse.data;
      subCategoryCosts.sort((a, b) {
        return b.childExitemsSumItemSum!.compareTo(a.childExitemsSumItemSum!);
      });
    }
  }

  void getSubcategoryCostItems(String label) async {
    if (page.value == 0) {
      subcategoryCostItemsLoading.value = true;
    } else {
      nextPageLoading.value = true;
    }
    CustomResponse customResponse =
        await categoryService.getSubCategoryCostItems(
            label,
            subcategoryCostItemsResponse.value == null
                ? null
                : subcategoryCostItemsResponse.value!.nextPageUrl);
    subcategoryCostItemsLoading.value = false;
    nextPageLoading.value = false;

    if (customResponse.status == Status.COMPLETED) {
      if (page.value == 0) {
        subcategoryCostItemsResponse.value = customResponse.data;
      } else {
        SubCategoryCostItemResponse nextPageData = customResponse.data;
        subcategoryCostItemsResponse.value!.items = [
          ...subcategoryCostItemsResponse.value!.items!,
          ...nextPageData.items!
        ];
        subcategoryCostItemsResponse.value!.nextPageUrl =
            nextPageData.nextPageUrl;
        subcategoryCostItemsResponse.refresh();
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}

import 'package:get/get.dart';
import 'package:lifeapp/pages/costs/category/category_service.dart';
import 'package:lifeapp/pages/costs/category/time_picker.dart';

import '../../../core/network/Response.dart';
import '../main_cost_response.dart';
import 'category_response.dart';

class CategoryController extends GetxController {
  final CategoryService _categoryService = CategoryService();
  RxList<CategoryResponse> categoryCosts = RxList();
  RxList<CategoryResponse> categories = RxList();
  DatePickerController _datePickerController = Get.put(DatePickerController());

  void getCategoryCosts() async {
    CustomResponse customResponse = await _categoryService.getCategoriesAll();

    if (customResponse.status == Status.COMPLETED) {
      categoryCosts.value = customResponse.data;
      categoryCosts.refresh();
    }
  }

  void getCategories() async {
    CustomResponse customResponse = await _categoryService.getCategories();
    if (customResponse.status == Status.COMPLETED) {
      categories.value = customResponse.data;
      categories.refresh();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCategoryCosts();
    getCategories();
  }
}

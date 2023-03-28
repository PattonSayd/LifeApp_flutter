import 'package:get/get.dart';
import 'package:lifeapp/pages/costs/category/category_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(() => CategoryController());
  }
}

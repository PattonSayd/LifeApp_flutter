import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/pages/manual_add_cost/cost_item.dart';
import 'package:lifeapp/pages/manual_add_cost/manual_cost_service.dart';

class ManualCostAddController extends GetxController {
  RxList<ManualCostItem> items = RxList();
  final ManualCostService manualCostService = ManualCostService();
  RxBool loading = false.obs;
  RxString priceError = "".obs;
  RxString countError = "".obs;

  void add(String name, double price, int count, String comment) {
    ManualCostItem manualCostItem = ManualCostItem(
        name: name, price: price, count: count, comment: comment);

    items.add(manualCostItem);
    items.refresh();
  }

  Future<void> upload(String storeName) async {
    loading.value = true;
    await manualCostService.uploadCosts(items, storeName);
    loading.value = false;
    items.value = [];
    items.refresh();
    Get.showSnackbar(GetSnackBar(
      title: "Success",
      message: "Created successfully",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      duration: Duration(milliseconds: 1000),
    ));
  }
}

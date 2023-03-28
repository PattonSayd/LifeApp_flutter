import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/quick_add/quick_add.dart';
import 'package:lifeapp/pages/quick_add/quick_add_request_dto.dart';
import 'package:lifeapp/pages/quick_add/quick_add_service.dart';

class QuickAddController extends GetxController {
  final QuickAddService quickAddService = QuickAddService();
  RxList<QuickAdd> items = RxList();
  RxList<QuickAddRequestDto> sendList = RxList();
  RxBool loading = false.obs;
  RxBool saveLoading = false.obs;
  RxBool deleteLoading = false.obs;
  RxInt selectedTagId = 0.obs;

  Future<void> create(String name, double price, int tagId) async {
    loading.value = true;
    QuickAdd quickAdd = QuickAdd(itemName: name, itemPrice: price, tagId: tagId);
    loading.value = false;
    await quickAddService.create(quickAdd);
    getAll();
  }

  Future<void> edit(String name, double price, int tagId, int id) async {
    loading.value = true;
    QuickAdd quickAdd =
        QuickAdd(itemName: name, itemPrice: price, tagId: tagId, id: id);
    await quickAddService.edit(quickAdd);
    loading.value = false;
    getAll();
  }

  Future<void> delete(int id) async {
    deleteLoading.value = true;
    await quickAddService.delete(id);
    deleteLoading.value = false;
    getAll();
  }

  void getAll() async {
    loading.value = true;
    CustomResponse response = await quickAddService.getAll();
    loading.value = false;
    if (response.status == Status.COMPLETED) {
      sendList.clear();
      items.value = response.data;
      items.refresh();
      for (QuickAdd quickAdd in items) {
        sendList.add(QuickAddRequestDto(
            price: quickAdd.itemPrice, count: 1, loading: false));
        sendList.refresh();
      }
    }
  }

  void addToCosts(int index) async {
    QuickAdd quickAdd = items[index];
    QuickAddRequestDto quickAddSendDto = sendList[index];
    sendList[index].loading = true;
    sendList.refresh();
    CustomResponse customResponse = await quickAddService.addToCosts(
        quickAdd.id!,
        quickAddSendDto.price! * quickAddSendDto.count!,
        quickAddSendDto.count!,
        quickAddSendDto.price!);
    sendList[index].loading = false;
    sendList.refresh();
    if (customResponse.status == Status.COMPLETED) {
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
}

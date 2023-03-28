import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/costs/tag/tag_costs_response.dart';
import 'package:lifeapp/pages/costs/tag/tag_response_dto.dart';
import 'package:lifeapp/pages/costs/tag/tag_service.dart';

import '../category/time_picker.dart';

class TagController extends GetxController {
  final TagService tagService = TagService();
  RxBool saveLoading = false.obs;
  RxBool deleteLoading = false.obs;
  RxBool loading = false.obs;
  Rxn<TagResponseDto> tagResponse = Rxn();
  RxList<TagCostsResponse> tagCosts = RxList();
  RxList<TagCostsResponse> tagCostsShort = RxList();
  DatePickerController _datePickerController = Get.put(DatePickerController());

  Future<void> create(String name, String comment) async {
    saveLoading.value = true;
    CustomResponse customResponse = await tagService.create(name, comment);
    saveLoading.value = false;

    if (customResponse.status == Status.COMPLETED) {
      getAll();
      getAllTagCosts();
      getShortTagCosts();
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

  Future<void> edit(String name, String comment, int id) async {
    saveLoading.value = true;
    CustomResponse customResponse = await tagService.edit(name, comment, id);
    saveLoading.value = false;

    if (customResponse.status == Status.COMPLETED) {
      getAll();
      getAllTagCosts();
      getShortTagCosts();
      Get.showSnackbar(GetSnackBar(
        title: "Success",
        message: "Updated successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        duration: Duration(milliseconds: 1000),
      ));
    }
  }

  void getAll() async {
    loading.value = true;
    CustomResponse customResponse = await tagService.getAll();
    loading.value = false;
    if (customResponse.status == Status.COMPLETED) {
      tagResponse.value = customResponse.data;
      tagCosts.sort((a, b) {
        return b.exitemsSumItemSum!.compareTo(a.exitemsSumItemSum!);
      });
    }
  }

  void getAllTagCosts() async {
    loading.value = true;
    CustomResponse customResponse = await tagService.getAllTagCosts(
        _datePickerController.fromDate.value,
        _datePickerController.toDate.value);
    loading.value = false;
    if (customResponse.status == Status.COMPLETED) {
      tagCosts.value = customResponse.data;
    }
  }

  void getShortTagCosts() async {
    CustomResponse customResponse = await tagService.getShortTagCosts();
    if (customResponse.status == Status.COMPLETED) {
      tagCostsShort.value = customResponse.data;
    }
  }

  Tag getById(int id) {
    return tagResponse.value!.tags!
        .where((element) => element.id == id)
        .toList()[0];
  }

  Future<void> delete(int index) async {
    deleteLoading.value = true;
    CustomResponse customResponse =
        await tagService.delete(tagResponse.value!.tags![index].id!);
    deleteLoading.value = false;
    tagResponse.value!.tags!.removeAt(index);
    tagResponse.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    getAll();
    getShortTagCosts();
    getAllTagCosts();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/costs/cost_controller.dart';
import 'package:lifeapp/pages/expenditure/expenditure_response.dart';
import 'package:lifeapp/pages/expenditure/category_response.dart';
import 'package:lifeapp/pages/expenditure/expenditure_request.dart';
import 'package:lifeapp/pages/expenditure/expenditure_service.dart';

class ExpenditureController extends GetxController {
  final ExpenditureService expenditureService = ExpenditureService();
  RxString type = "".obs;
  RxList<Category> categories = RxList();
  RxInt selectedCategoryId = 0.obs;
  RxInt selectedTagId = 0.obs;
  RxBool loading = false.obs;
  Rxn<ExpenditureResponse> unFinishedExpenditureResponse = Rxn();
  Rxn<ExpenditureResponse> finishedExpenditureResponse = Rxn();

  void getAllCategories() async {
    CustomResponse customResponse = await expenditureService.getAllCategories();

    if (customResponse.status == Status.COMPLETED) {
      categories.value = customResponse.data;
    }
  }

  void getAllUnFinishedExpenditures() async {
    CustomResponse customResponse = await expenditureService.getAllUnFinished();
    if (customResponse.status == Status.COMPLETED) {
      unFinishedExpenditureResponse.value = customResponse.data;
    }
  }

  void getAllFinishedExpenditures() async {
    CustomResponse customResponse = await expenditureService.getAllFinished();
    if (customResponse.status == Status.COMPLETED) {
      finishedExpenditureResponse.value = customResponse.data;
    }
  }

  void create(ExpenditureRequest expenditureRequest) async{
    loading.value = true;
    CustomResponse customResponse =  await expenditureService.create(expenditureRequest);
    loading.value = false;
    if (customResponse.status == Status.COMPLETED) {
      getAllFinishedExpenditures();
      getAllUnFinishedExpenditures();
      CostController costController = Get.find();
      costController.getAllExpenditures();
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

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
    getAllUnFinishedExpenditures();
    getAllFinishedExpenditures();
  }
}

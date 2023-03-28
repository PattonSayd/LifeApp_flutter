import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/targets/target_payments.dart';
import 'package:lifeapp/pages/targets/target_response.dart';
import 'package:lifeapp/pages/targets/target_service.dart';

class TargetsController extends GetxController {
  final TargetService targetService = TargetService();
  Rxn<TargetResponseDto> targets = Rxn();
  RxList<Target> homeTargets = RxList();
  RxBool loading = false.obs;
  RxString selectedFund = ''.obs;
  RxBool payLoading = false.obs;
  RxInt selectedFundId = 0.obs;
  RxList<GoalPayment> goalPayment = RxList();

  @override
  void onInit() {
    super.onInit();
    getAll();
    getHomeTargets();
  }

  void getAll() async {
    loading.value = true;
    CustomResponse customResponse = await targetService.getAll();
    loading.value = false;

    if (customResponse.status == Status.COMPLETED) {
      targets.value = customResponse.data;
    }
  }

  void getHomeTargets() async {
    CustomResponse customResponse = await targetService.getHomeTargets();

    if (customResponse.status == Status.COMPLETED) {
      homeTargets.value = customResponse.data;
    }
  }

  void getPayments(int goalId) async {
    CustomResponse customResponse = await targetService.getPayments(goalId);

    if (customResponse.status == Status.COMPLETED) {
      goalPayment.value = customResponse.data;
    }
  }

  Future<void> pay(double sum, int goalId, int fundId) async {
    payLoading.value = true;
    CustomResponse customResponse =
        await targetService.pay(goalId, fundId, sum);
    payLoading.value = false;
    if (customResponse.status == Status.COMPLETED) {
      Get.showSnackbar(GetSnackBar(
        title: "Success",
        message: "Payed successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        duration: Duration(milliseconds: 1000),
      ));
      getPayments(goalId);
      getHomeTargets();
      getAll();
    }
  }
}

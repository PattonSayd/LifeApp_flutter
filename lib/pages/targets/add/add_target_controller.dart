import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/targets/add/target_requeset_dto.dart';
import 'package:lifeapp/pages/targets/target_service.dart';
import 'package:lifeapp/pages/targets/targets_controller.dart';

class AddTargetController extends GetxController {
  final TargetService targetService = TargetService();
  RxBool loading = false.obs;
  RxString nameError = "".obs;
  RxString priceError = "".obs;
  RxString startDateError = "".obs;
  RxString endDateError = "".obs;

  void create(TargetRequestDto targetRequestDto) async {
    loading.value = true;
    CustomResponse customResponse =
        await targetService.create(targetRequestDto);
    loading.value = false;
    if (customResponse.status == Status.COMPLETED) {
      TargetsController targetsController = Get.find();
      targetsController.getAll();
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

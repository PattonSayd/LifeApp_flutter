import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/my_funds/create/my_funds_request_dto.dart';
import 'package:lifeapp/pages/my_funds/my_funds_controller.dart';
import 'package:lifeapp/pages/my_funds/my_funds_service.dart';

class FundCreateController extends GetxController {
  final FundsService fundsService = FundsService();

  RxString nameError = "".obs;
  RxString balanceError = "".obs;
  RxString identityNumberError = "".obs;
  RxBool loading = false.obs;

  void create(MyFundsRequestDto fundsRequestDto)async{
    print(fundsRequestDto.type);
    loading.value = true;
    CustomResponse customResponse = await fundsService.create(fundsRequestDto);
    loading.value = false;
    if(customResponse.status == Status.COMPLETED){
      MyFundsController fundsController =Get.find();
      fundsController.getMyFunds();
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

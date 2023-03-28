import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/bonus_card/bonus_card_service.dart';
import 'package:lifeapp/pages/my_funds/my_funds_controller.dart';

class AddBonusCardController extends GetxController{
  final BonusCardService bonusCardService = BonusCardService();
  RxBool loading = false.obs;

  void add(String code, String name)async{
    loading.value = true;
    CustomResponse customResponse = await bonusCardService.create(code, name);
    loading.value = false;
    Get.showSnackbar(GetSnackBar(
      title: "Success",
      message: "Created successfully",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      duration: Duration(milliseconds: 1000),
    ));

    MyFundsController myFundsController = Get.find();
    myFundsController.getBonusCards();
  }

}
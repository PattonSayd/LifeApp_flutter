import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/bonus_card/bonus_card_service.dart';
import 'package:lifeapp/pages/my_funds/models/bonus_cart.dart';
import 'package:lifeapp/pages/my_funds/my_funds_service.dart';

import 'fund_response.dart';

class MyFundsController extends GetxController {
  final BonusCardService bonusCardService = BonusCardService();
  final FundsService fundService = FundsService();
  RxList<BonusCard> bonusCards = RxList();
  Rxn<FundResponseDto> myFunds = Rxn();
  RxString cash = "".obs;
  RxString nonCash = "".obs;
  RxString sum = "".obs;

  @override
  void onInit() {
    super.onInit();
    getMyFunds();
    getBonusCards();
    getBalance();
  }

  void getBalance() async {
    CustomResponse customResponse = await fundService.getBalance();
    if (customResponse.status == Status.COMPLETED) {
      nonCash.value = customResponse.data['non-cash'].toString();
      cash.value = customResponse.data['cash'].toString();
      sum.value = (customResponse.data['non-cash'] + customResponse.data['cash']).toString();
    }
  }

  void getMyFunds() async {
    CustomResponse customResponse = await fundService.getAll();
    if (customResponse.status == Status.COMPLETED) {
      myFunds.value = customResponse.data;
    }
  }

  void getBonusCards() async {
    CustomResponse customResponse = await bonusCardService.getAll();

    if (customResponse.status == Status.COMPLETED) {
      bonusCards.value = customResponse.data;
      bonusCards.refresh();
    }
  }

  void deleteBonusCard(int index) async {
    CustomResponse customResponse =
        await bonusCardService.delete(bonusCards.value[index].id.toString());
    bonusCards.removeAt(index);
    bonusCards.refresh();
    if (customResponse.status == Status.COMPLETED) {
      Get.showSnackbar(GetSnackBar(
        title: "Success",
        message: "Deleted successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        duration: Duration(milliseconds: 1000),
      ));
    }
  }
}

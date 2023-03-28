import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/register/register_error_dto.dart';
import 'package:lifeapp/pages/register/register_error_response_dto.dart';
import 'package:lifeapp/pages/register/register_service.dart';
import 'package:lifeapp/core/network/Response.dart'  ;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  final RegisterService registerService = RegisterService();

  RxBool loading = false.obs;
  RxString error = "".obs;
  Rxn<RegisterError> registerError = Rxn<RegisterError>();
  RxBool passwordShowing = true.obs;
  RxBool confirmPasswordShowing = true.obs;
  RxBool termsAccepted = false.obs;

  void togglePasswordShowing(){
    passwordShowing.value = !passwordShowing.value;
  }

  void toggleConfirmPasswordShowing(){
    confirmPasswordShowing.value = !confirmPasswordShowing.value;
  }

  void acceptTermsAndConditions(){
    termsAccepted.value = true;
  }

  void register(String name, String phone, String email, String password,
      String confirmPassword, context) async {
    if(!termsAccepted.value){
      Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: "Please accept Terms and Conditions",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: CustomColors.errorRed,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        duration: Duration(milliseconds: 1000),
      ));
      return;
    }

    loading.value = true;
    error.value = "";
    registerError.value = RegisterError();

    CustomResponse response = await registerService.register(
        name, phone, email, password, confirmPassword);
    loading.value = false;


    if (response.status == Status.COMPLETED) {
      Navigator.pushNamedAndRemoveUntil(
          context, "/pages.login", (route) => false);
    }
    else if (response.status == Status.ERROR) {
      RegisterErrorResponseDto registerErrorResponseDto = response.data;

      if (registerErrorResponseDto.errors?.name != null) {
        switch (registerErrorResponseDto.errors?.name?[0]) {
          case "validation.required":
            registerError.value!.name = Languages.of(context)!.nameCantBeEmpty;
            break;
        }
      }

      if (registerErrorResponseDto.errors?.phone != null) {
        switch (registerErrorResponseDto.errors?.phone?[0]) {
          case "validation.required":
            registerError.value!.phone =
                Languages.of(context)!.phoneCantBeEmpty;
            break;
          case "validation.unique":
            registerError.value!.phone =
                Languages.of(context)!.phoneAlreadyUsed;
            break;
        }
      }

      if (registerErrorResponseDto.errors?.email != null) {
        switch (registerErrorResponseDto.errors?.email?[0]) {
          case "validation.required":
            registerError.value!.email =
                Languages.of(context)!.emailCantBeEmpty;
            break;
          case "validation.unique":
            registerError.value!.email =
                Languages.of(context)!.emailAlreadyUsed;
            break;
        }
      }

      if (registerErrorResponseDto.errors?.password != null) {
        switch (registerErrorResponseDto.errors?.password?[0]) {
          case "validation.required":
            registerError.value!.password =
                Languages.of(context)!.passwordCantBeEmpty;
            break;
          case "validation.confirmed":
            registerError.value!.confirmPassword =
                Languages.of(context)!.passwordsDonTMatch;
            break;
        }
      }

      registerError.refresh();

    }
  }
}

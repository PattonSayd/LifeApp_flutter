import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/localization/languages/languages.dart';
import 'package:lifeapp/pages/login/login_service.dart';
import 'package:lifeapp/pages/login/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final LoginService loginService = LoginService();

  RxBool passwordShowing = true.obs;
  RxBool loading = false.obs;
  RxString error = "".obs;
  RxBool confirmButtonShowing = false.obs;

  void togglePassword() {
    passwordShowing.value = !passwordShowing.value;
  }

  void login(String email, String password, context) async {
    loading.value = true;
    confirmButtonShowing.value = false;
    error.value = "";

    CustomResponse response = await loginService.login(email, password);
    loading.value = false;

    if (response.status == Status.COMPLETED) {
      LoginResponse loginResponseData = response.data;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = loginResponseData.accessToken!.substring(
          loginResponseData.accessToken!.indexOf('|') + 1,
          loginResponseData.accessToken!.length);

      if (loginResponseData.emailVerified == 0) {
        error.value = Languages.of(context)!.accountNotConfirmed;
        prefs.setString("token", token);
        confirmButtonShowing.value = true;
      } else {
        prefs.setString("token", token);
        prefs.setBool("logined", true);
        Navigator.pushNamedAndRemoveUntil(
            context, "/pages.main", (route) => false);
      }
    } else {
      error.value = response.data!;
      if (response.data == "verify_email") {
        error.value = Languages.of(context)!.accountNotConfirmed;
      }
    }
  }
}

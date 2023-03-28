import 'package:get/get.dart';
import 'package:lifeapp/pages/account_verification/account_service.dart';
import 'package:lifeapp/core/network/Response.dart';

class AccountVerificationController extends GetxController {
  final AccountVerificationService accountVerificationService =
      AccountVerificationService();

  RxBool loading = false.obs;
  RxBool success = false.obs;
  RxBool error = false.obs;
  RxInt nextTime = 0.obs;

  void resendEmail() async {
    loading.value = true;
    success.value = false;
    error.value = false;

    CustomResponse response =
        await accountVerificationService.resendVerificationLink();

    if (response.status == Status.COMPLETED) {
      success.value = true;
    } else {
      error.value = true;
      nextTime.value = response.data;
    }

    loading.value = false;
  }
}

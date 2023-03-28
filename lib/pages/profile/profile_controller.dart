import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifeapp/pages/profile/profile_service.dart';
import 'package:lifeapp/pages/profile/user.dart';

import '../../core/network/Response.dart';

class ProfileController extends GetxController {
  final ProfileService profileService = ProfileService();
  RxBool saveLoading = false.obs;
  Rxn<User> user = Rxn();

  Future<void> getUser() async {
    CustomResponse customResponse = await profileService.get();
    if (customResponse.status == Status.COMPLETED) {
      user.value = customResponse.data;
    }
  }

  void save(User user) async {
    saveLoading.value = true;
    await profileService.create(user);
    saveLoading.value = false;
    getUser();
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

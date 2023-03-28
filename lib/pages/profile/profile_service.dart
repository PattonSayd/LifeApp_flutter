import 'package:dio/dio.dart';
import 'package:lifeapp/pages/profile/user.dart';

import '../../core/network/Response.dart';
import '../../core/network/network_manager.dart';

class ProfileService {
  NetworkManager networkManager = NetworkManager();

  Future<void> create(User user) async {
    Response apiResponse =
        await networkManager.post("/api/user-details/edit", user.toJson());

    print(apiResponse.data);
  }

  Future<CustomResponse> get() async {
    Response apiResponse = await networkManager.post("/api/user-details", {});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(userFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("error");
    }
  }
}

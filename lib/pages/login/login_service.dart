import 'package:dio/dio.dart';
import 'package:lifeapp/core/network/Response.dart'  ;
import 'package:lifeapp/core/network/network_manager.dart';
import 'package:lifeapp/pages/login/login_response.dart';

class LoginService {
  NetworkManager networkManager = NetworkManager();

  Future<CustomResponse> login(String email, String password) async {
    Response apiResponse = await networkManager.post("/api/auth/token",
          {"email": email, "password": password, "device_name": "."});

    if (apiResponse.statusCode == 200) {
      if (apiResponse.data['error'] != null) {
        return CustomResponse.error("incorrect credentials");
      } else {
        LoginResponse loginResponseData =
            loginResponseFromJson(apiResponse.data);
        return CustomResponse.completed(loginResponseData);
      }
    } else if (apiResponse.statusCode == 422) {
      return CustomResponse.error("incorrect mail");
    } else {
      return CustomResponse.error("server error");
    }
  }
}

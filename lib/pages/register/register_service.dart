import 'package:dio/dio.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/core/network/network_manager.dart';
import 'package:lifeapp/pages/register/register_error_response_dto.dart';

class RegisterService {
  NetworkManager networkManager = NetworkManager();

  Future<CustomResponse> register(String name, String phone, String email,
      String password, String confirmPassword) async {
    Response apiResponse = await networkManager.post("/api/auth/register", {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword
    });

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(true);
    } else if (apiResponse.statusCode == 422) {
      return CustomResponse.error(errorFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("server error");
    }
  }
}

import 'package:dio/dio.dart';
import 'package:lifeapp/core/network/network_manager.dart';
import 'package:lifeapp/core/network/Response.dart';

class AccountVerificationService {
  NetworkManager networkManager = NetworkManager();

  Future<CustomResponse> resendVerificationLink() async {
    Response apiResponse =
        await networkManager.post("/api/resend/mail-verification", {});

    print(apiResponse.data);

    if(apiResponse.statusCode == 200 ){
      return CustomResponse.completed(0);
    }else if(apiResponse.statusCode == 208 ){
      return CustomResponse.error(apiResponse.data['next_time']);
    }else{
      return CustomResponse.error("server error");
    }

  }
}

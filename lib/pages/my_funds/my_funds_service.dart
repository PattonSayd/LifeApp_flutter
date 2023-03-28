import 'package:dio/dio.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/my_funds/create/my_funds_request_dto.dart';
import 'package:lifeapp/pages/my_funds/fund_response.dart';
import 'package:lifeapp/pages/targets/add/target_requeset_dto.dart';
import 'package:lifeapp/pages/targets/target_response.dart';

import '../../core/network/network_manager.dart';

class FundsService {
  NetworkManager networkManager = NetworkManager();

  Future<CustomResponse> create(MyFundsRequestDto myFundsRequestDto) async {
    Response apiResponse =
    await networkManager.post("/api/wallet/add", myFundsRequestDto.toJson());
    print(apiResponse.data);
    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed("success");
    } else {
      return CustomResponse.error("error");
    }
  }

  Future<CustomResponse> getAll() async {
    Response apiResponse = await networkManager.post("/api/wallets", {});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(
          fundResponseDtoFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("error");
    }
  }

  Future<CustomResponse> getBalance() async {
    Response apiResponse = await networkManager.post("/api/wallet/balance", {});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(apiResponse.data);
    } else {
      return CustomResponse.error("error");
    }
  }
}

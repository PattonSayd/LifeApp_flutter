import 'package:dio/dio.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/targets/add/target_requeset_dto.dart';
import 'package:lifeapp/pages/targets/target_payments.dart';
import 'package:lifeapp/pages/targets/target_response.dart';

import '../../core/network/network_manager.dart';

class TargetService {
  NetworkManager networkManager = NetworkManager();

  Future<CustomResponse> create(TargetRequestDto targetRequestDto) async {
    Response apiResponse =
        await networkManager.post("/api/goal/add", targetRequestDto.toJson());

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed("success");
    } else {
      return CustomResponse.error("error");
    }
  }

  Future<CustomResponse> getAll() async {
    Response apiResponse = await networkManager.post("/api/goals", {});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(
          targetResponseDtoFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("error");
    }
  }

  Future<CustomResponse> getHomeTargets() async {
    Response apiResponse = await networkManager.post("/api/home/goals", {});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(targetFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("error");
    }
  }

  Future<CustomResponse> pay(int goalId, int fundId, double sum) async {
    Response apiResponse = await networkManager.post("/api/goal-input/add",
        {'goal_id': goalId, 'wallet_id': fundId, 'sum': sum});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed('success');
    } else {
      return CustomResponse.error("error");
    }
  }

  Future<CustomResponse> getPayments(int goalId) async {
    Response apiResponse =
        await networkManager.post("/api/goal", {'id': goalId});

    print(apiResponse.data);

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(
          goalPaymentFromJson(apiResponse.data['goal_input']));
    } else {
      return CustomResponse.error("error");
    }
  }
}

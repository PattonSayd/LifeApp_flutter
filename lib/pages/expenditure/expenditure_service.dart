import 'package:dio/dio.dart';
import 'package:lifeapp/pages/expenditure/category_response.dart';
import 'package:lifeapp/pages/expenditure/expenditure_request.dart';
import 'package:lifeapp/pages/expenditure/expenditure_response.dart';

import '../../core/network/Response.dart';
import '../../core/network/network_manager.dart';

class ExpenditureService {
  NetworkManager networkManager = NetworkManager();

  Future<CustomResponse> getAllCategories() async {
    Response apiResponse =
        await networkManager.post("/api/mlcategories/child", {});
    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(categoryFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("server error");
    }
  }

  Future<CustomResponse> create(ExpenditureRequest expenditureRequest) async {
    Response apiResponse = await networkManager.post(
        "/api/consumption/add", expenditureRequest.toJson());

    print(apiResponse.data);
    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed('success');
    } else {
      return CustomResponse.error("server error");
    }
  }

  Future<CustomResponse> getAllUnFinished() async {

    Response apiResponse = await networkManager.post(
        "/api/consumptions/not-completed", {});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(expenditureResponseFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("server error");
    }
  }

  Future<CustomResponse> getAllFinished() async {

    Response apiResponse = await networkManager.post(
        "/api/consumptions/completed", {});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(expenditureResponseFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("server error");
    }
  }
}

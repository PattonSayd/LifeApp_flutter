import 'package:lifeapp/core/network/network_manager.dart';
import 'package:lifeapp/core/network/Response.dart' as response;
import 'package:dio/dio.dart';
import 'package:lifeapp/pages/my_funds/models/bonus_cart.dart';
import 'package:lifeapp/pages/receipt/receipt.dart';

class BonusCardService {
  NetworkManager networkManager = NetworkManager();

  Future<response.CustomResponse> create(String code, String name) async {
    Response apiResponse = await networkManager
        .post("/api/loyaltycard/add", {"code": code, "vendor": name});

    if (apiResponse.statusCode == 200) {
      return response.CustomResponse.completed("success");
    } else {
      return response.CustomResponse.error("server error");
    }
  }

  Future<response.CustomResponse> getAll() async {
    Response apiResponse = await networkManager
        .post("/api/loyaltycards", {});

    if (apiResponse.statusCode == 200) {
      List<BonusCard> bonusCards = bonusCardFromJson(apiResponse.data["data"]);
      return response.CustomResponse.completed(bonusCards);
    } else {
      return response.CustomResponse.error("server error");
    }
  }

  Future<response.CustomResponse> delete(String id) async {
    Response apiResponse = await networkManager
        .post("/api/loyaltycard/destroy", {"id": id});

    if (apiResponse.statusCode == 200) {
      return response.CustomResponse.completed("success");
    } else {
      return response.CustomResponse.error("server error");
    }
  }
}

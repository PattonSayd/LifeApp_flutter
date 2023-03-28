import 'package:dio/dio.dart';
import 'package:lifeapp/core/network/network_manager.dart';
import 'package:lifeapp/pages/quick_add/quick_add.dart';
import 'package:lifeapp/core/network/Response.dart';

class QuickAddService {
  NetworkManager networkManager = NetworkManager();

  Future<void> create(QuickAdd quickAddItem) async {
    Response apiResponse = await networkManager.post(
        "/api/dailyexitem/creat", quickAddToJson(quickAddItem));
  }

  Future<void> edit(QuickAdd quickAddItem) async {
    Response apiResponse = await networkManager.post(
        "/api/dailyexitem/edit", quickAddItem.toJson());
  }

  Future<void> delete(int id) async {
    Response apiResponse =
        await networkManager.post("/api/dailyexitem/destroy", {"id": id});

  }

  Future<CustomResponse> getAll() async {
    Response apiResponse = await networkManager.post("/api/dailyexitems", {});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(quickAddFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("error");
    }
  }

  Future<CustomResponse> addToCosts(
      int id, double sum, int count, double price) async {
    Response apiResponse = await networkManager.post(
        "/api/dailyexitem/exitem/add",
        {"id": id, "item_sum": sum, "item_count": count, "item_price": price});

    print(apiResponse.data);

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed("success");
    } else {
      return CustomResponse.error("error");
    }
  }
}

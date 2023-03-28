import 'package:lifeapp/core/network/network_manager.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:dio/dio.dart';
import 'package:lifeapp/pages/receipt/receipt.dart';

class ReceiptService {
  NetworkManager networkManager = NetworkManager();

  Future<CustomResponse> addReceipt(String fiscal) async {
    Response apiResponse =
        await networkManager.post("/api/check-scan", {"fiscal": fiscal});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(apiResponse.data['id']);
    } else if (apiResponse.statusCode == 202) {
      return CustomResponse.error("already exists");
    } else {
      return CustomResponse.error("server error");
    }
  }

  Future<CustomResponse> getReceipt(String checkId) async {
    Response apiResponse =
        await networkManager.post("/api/check/items", {"check_id": checkId});
    print(checkId);
    print(apiResponse.data);
    if (apiResponse.statusCode == 200) {
      Receipt receipts = receiptFromJson(apiResponse.data);
      return CustomResponse.completed(receipts);
    } else {
      return CustomResponse.error("server error");
    }
  }

  Future<CustomResponse> addTagToReceiptItem(int id, int tagId) async {
    Response apiResponse = await networkManager
        .post("/api/exitem/add-tag", {"id": id, "tag_id": tagId});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed("success");
    } else {
      return CustomResponse.error("server error");
    }
  }

  Future<CustomResponse> changeCategory(int id, String mlCategory) async {
    Response apiResponse = await networkManager.post(
        "/api/exitem/change-category",
        {"id": id, "ml_category_id": mlCategory});

    print(apiResponse.data);

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed("success");
    } else {
      return CustomResponse.error("server error");
    }
  }
}

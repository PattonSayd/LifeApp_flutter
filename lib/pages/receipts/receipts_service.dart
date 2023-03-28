import 'package:dio/dio.dart';
import 'package:lifeapp/core/network/network_manager.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/receipts/receipt_response.dart';

class ReceiptsService {
  final NetworkManager networkManager = NetworkManager();

  Future<CustomResponse> getAll(String? nextPageUrl) async {
    Response apiResponse =
        await networkManager.post(nextPageUrl ?? "/api/checks", {});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(
          receiptResponseFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("error");
    }
  }
}

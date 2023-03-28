import 'package:dio/dio.dart';
import '../../../../../core/network/Response.dart';
import '../../../../../core/network/network_manager.dart';
import '../examine_receipt/models/save_receipt.dart';

class CreateReceiptService {
  NetworkManager networkManager = NetworkManager();

  Future<CustomResponse> saveReceipt(SaveReceipt saveReceipt) async {
    Response apiResponse =
        await networkManager.post("/api/add-exitems", saveReceipt.toJson());
    print(apiResponse.data);
    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(apiResponse.data['check_id']);
    } else if (apiResponse.statusCode == 202) {
      return CustomResponse.error("already exists");
    } else {
      return CustomResponse.error("server error");
    }
  }
}

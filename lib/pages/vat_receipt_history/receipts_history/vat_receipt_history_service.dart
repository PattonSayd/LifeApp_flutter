import 'package:dio/dio.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/vat_receipt_history/receipts_history/vat_receipt.dart';

import '../../../core/network/network_manager.dart';

class VatReceiptHistoryService {
  NetworkManager networkManager = NetworkManager();

  Future<CustomResponse> getAll(String cookie, int page) async {
    Dio dio = Dio(BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (_) => true))
      ..options.connectTimeout = 10000
      ..options.receiveTimeout
      ..options.headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Cookie": cookie
      };

    Response apiResponse = await dio.post(
        'https://edvgerial.kapitalbank.az/api/v1/cashback/history',
        data: {
          "states": ["SCHEDULED", "COMPLETED", "FAIL"],
          "paging": {"page": page, "limit": 50}
        });

    print(apiResponse.data);
    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(
          vatReceiptHistoryFromJson(apiResponse.data));
    } else {
      return CustomResponse.error('error');
    }
  }
}

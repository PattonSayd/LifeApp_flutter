import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../core/network/network_manager.dart';
import 'models/categories.dart';
import 'models/receipt_text.dart';


class ExamineReceiptService{
  NetworkManager networkManager = NetworkManager();

  Future<ReceiptText> getReceipt(File file) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path),
    });
    Response response = await Dio()
        .post('http://tr.lifeplus.website:8000/uploadfile/', data: formData);
    if (response.statusCode == 200) {
      return receiptFromJson(response.data);
    } else {
      throw Exception('Error');
    }
  }

  Future<Categories> getCategories(List<String> names) async {
    var data = {"task_id": 0, "products": names};
    Response response = await Dio()
        .post('http://cr.lifeplus.website/select_category/', data: data);
    if (response.statusCode == 200) {
      return categoriesFromJson(response.data);
    } else {
      throw Exception('Error');
    }
  }

}
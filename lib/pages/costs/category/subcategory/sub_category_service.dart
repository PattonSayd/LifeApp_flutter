import 'dart:math';

import 'package:lifeapp/core/network/network_manager.dart';
import 'package:lifeapp/core/network/Response.dart' as response;
import 'package:dio/dio.dart';
import 'package:lifeapp/pages/costs/category/category_response.dart';
import 'package:lifeapp/pages/costs/category/subcategory/cost_items/subcategory_cost_item_response.dart';
import 'package:lifeapp/pages/costs/category/subcategory/subcategory_cost_response.dart';
import 'package:lifeapp/pages/costs/expenditures.dart';
import 'package:lifeapp/pages/costs/main_cost_response.dart';

class SubCategoryService {
  NetworkManager networkManager = NetworkManager();

  Future<response.CustomResponse> getSubCategories(String label) async {
    Response apiResponse = await networkManager
        .post("/api/mlcategories/child-by-parent", {'label': label});

    if (apiResponse.statusCode == 200) {
      return response.CustomResponse.completed(
          categoryFromJson(apiResponse.data));
    } else {
      return response.CustomResponse.error("server error");
    }
  }

  Future<response.CustomResponse> getSubCategoryCosts(
      int label) async {
    Response apiResponse = await networkManager.post(
        "/api/categories/child/exitems-sum",
        {'label': label});
    print(apiResponse.data);
    if (apiResponse.statusCode == 200) {
      return response.CustomResponse.completed(
          subCategoryCostResponseFromJson(apiResponse.data));
    } else {
      return response.CustomResponse.error("server error");
    }
  }

  Future<response.CustomResponse> getSubCategoryCostItems(
      String label, String? nextPageUrl) async {
    Response apiResponse = await networkManager
        .post(nextPageUrl ?? "/api/exitems/by-category", {'label': label});

    print('data : ' + apiResponse.data.toString());

    if (apiResponse.statusCode == 200) {
      return response.CustomResponse.completed(
          subCategoryCostItemResponseFromJson(apiResponse.data));
    } else {
      return response.CustomResponse.error("server error");
    }
  }
}

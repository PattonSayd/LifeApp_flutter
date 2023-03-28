import 'package:lifeapp/core/network/network_manager.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:dio/dio.dart';
import 'package:lifeapp/pages/costs/category/category_response.dart';
import 'package:lifeapp/pages/costs/expenditures.dart';
import 'package:lifeapp/pages/costs/main_cost_response.dart';

class CategoryService {
  NetworkManager networkManager = NetworkManager();

  Future<CustomResponse> getCategoryCosts(
      String fromDate, String toDate) async {
    Response apiResponse = await networkManager.post(
        "/api/mlcategories/parent/exitems-sum",
        {'from_date': fromDate, 'to_date': toDate});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(costFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("server error");
    }
  }

  Future<CustomResponse> getCategories() async {
    Response apiResponse =
        await networkManager.post("/api/mlcategories/parent", {});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(categoryFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("server error");
    }
  }

  Future<CustomResponse> getCategoriesAll() async {
    Response apiResponseSum =
        await networkManager.post("/api/categories/parent/exitems-sum", {});
    Response apiResponseCategory =
        await networkManager.post("/api/categories/parent", {});
    var sumList = apiResponseSum.data['sum']['category_item_sum']['buckets'];
    List<dynamic> categories = apiResponseCategory.data;
    List<CategoryResponse> categoriesWithSum = [];

    for (var sum in sumList) {
      CategoryResponse categoryResponse = CategoryResponse();
      categoryResponse.sum =
          double.parse(sum['category_sum']['value'].toString());
      for (var category in categories) {
        if (sum['key'] == category['id']) {
          categoryResponse.id = category['id'];
          categoryResponse.name = category['name'];
          categoryResponse.label = category['label'];
          categoryResponse.importLabel = category['import_label'];
          break;
        }
      }
      if (categoryResponse.name != null) {
        categoriesWithSum.add(categoryResponse);
      }
    }
    print(categoriesWithSum);
    return CustomResponse.completed(categoriesWithSum);
  }
}
import 'package:dio/dio.dart';
import 'package:lifeapp/pages/costs/tag/tag_cost_items/tag_cost_items_response.dart';
import 'package:lifeapp/pages/costs/tag/tag_costs_response.dart';
import 'package:lifeapp/pages/costs/tag/tag_response_dto.dart';

import '../../../core/network/Response.dart';
import '../../../core/network/network_manager.dart';

class TagService {
  NetworkManager networkManager = NetworkManager();

  Future<CustomResponse> create(String name, String comment) async {
    Response apiResponse = await networkManager
        .post("/api/tag/add", {"name": name, "comment": comment});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed("success");
    } else {
      return CustomResponse.error("server error");
    }
  }

  Future<CustomResponse> edit(String name, String comment, int id) async {
    Response apiResponse = await networkManager
        .post("/api/tag/edit", {"name": name, "comment": comment, "id": id});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed("success");
    } else {
      return CustomResponse.error("server error");
    }
  }

  Future<CustomResponse> getAll() async {
    Response apiResponse = await networkManager.post("/api/tags", {});
    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(tagResponseDtoFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("server error");
    }
  }

  Future<CustomResponse> getAllTagCosts(String fromDate, String toDate) async {
    Response apiResponseSum =
        await networkManager.post("/api/tags/exitems-sum", {});
    Response apiResponseTag = await networkManager.post("/api/tags", {});
    var sumList = apiResponseSum.data['sum']['tag_item_sum']['buckets'];
    List<dynamic> tags = apiResponseTag.data['data'];
    List<TagCostsResponse> tagsWithSum = [];

    for (var sum in sumList) {
      TagCostsResponse tagCostsResponse = TagCostsResponse();
      tagCostsResponse.exitemsSumItemSum =
          double.parse(sum['tag_sum']['value'].toString());
      for (var tag in tags) {
        if (sum['key'] == tag['id']) {
          tagCostsResponse.name = tag['name'];
          tagCostsResponse.comment = tag['comment'];
          tagCostsResponse.id = tag['id'];
          break;
        }
      }
      if (tagCostsResponse.name != null) {
        tagsWithSum.add(tagCostsResponse);
      }
    }
    return CustomResponse.completed(tagsWithSum);
  }

  Future<CustomResponse> getShortTagCosts() async {
    Response apiResponse =
        await networkManager.post("/api/tags/exitems-sum/short-list", {});
    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(
          tagCostsResponseFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("server error");
    }
  }

  Future<CustomResponse> delete(int id) async {
    Response apiResponse =
        await networkManager.post("/api/tag/destroy", {"id": id});

    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed("success");
    } else {
      return CustomResponse.error("server error");
    }
  }

  Future<CustomResponse> getTagCostItems(
      int tagId, String? nextPageUrl, String fromDate, String toDate) async {
    Response apiResponse = await networkManager.post(
        nextPageUrl ?? "/api/exitems/by-tag",
        {'tag_id': tagId, 'from_date': fromDate, 'to_date': toDate});
    if (apiResponse.statusCode == 200) {
      return CustomResponse.completed(tagCostItemsFromJson(apiResponse.data));
    } else {
      return CustomResponse.error("server error");
    }
  }
}

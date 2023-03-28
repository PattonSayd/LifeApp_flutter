import 'package:lifeapp/core/network/network_manager.dart';
import 'package:lifeapp/pages/manual_add_cost/cost_item.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:dio/dio.dart';
import 'package:lifeapp/pages/manual_add_cost/cost_iten_request.dart';

class ManualCostService {
  NetworkManager networkManager = NetworkManager();

  Future<void> uploadCosts(
      List<ManualCostItem> manualCostItems, String storeName) async {
    List<ManualCost> items = [];

    for (int i = 0; i < manualCostItems.length; i++) {
      ManualCostItem manualCostItem = manualCostItems[i];
      ManualCost manualCost = ManualCost();
      Data data = Data(
          itemName: manualCostItem.name,
          itemPrice: manualCostItem.price.toString(),
          itemCount: manualCostItem.count.toString(),
          itemSum: (manualCostItem.price! * manualCostItem.count!).toString(),
          comment: manualCostItem.comment,
          userCategoryId: 1);
      manualCost.id = i;
      manualCost.data = data;
      items.add(manualCost);
    }

    Response apiResponse = await networkManager.post("/api/exitem/creat",
        {'items': items, 'store_name': storeName});
    print(apiResponse.data);
  }
}

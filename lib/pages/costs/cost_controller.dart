import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/costs/costs_service.dart';
import 'package:lifeapp/pages/costs/expenditures.dart';
import 'package:lifeapp/pages/costs/main_cost_response.dart';

import 'category/category_response.dart';

class CostController extends GetxController {
  final CostService costService = CostService();

  Rxn<ExpenditureResponse> expenditureResponse = Rxn();
  RxList<CategoryResponse> mainCostsShort = RxList();

  void getAllExpenditures() async {
    CustomResponse customResponse = await costService.getAllExpenditures();

    if (customResponse.status == Status.COMPLETED) {
      expenditureResponse.value = customResponse.data;
    }
  }

  void getMainCostsShort() async {
    CustomResponse customResponse = await costService.getAllCosts();

    if (customResponse.status == Status.COMPLETED) {
      mainCostsShort.value = customResponse.data;
      mainCostsShort.refresh();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAllExpenditures();
    getMainCostsShort();
  }
}

import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';

import '../examine_receipt/models/product.dart';
import '../examine_receipt/models/save_receipt.dart';
import 'create_receipt_service.dart';

class ResultController extends GetxController {
  final CreateReceiptService createReceiptService = CreateReceiptService();
  RxBool loading = true.obs;
  RxBool success = false.obs;
  RxInt uploadedReceiptId = RxInt(0);

  void saveReceipt(List<Product> products, SaveReceipt saveReceiptModel) async {
    loading.value = true;
    saveReceiptModel.items = [];
    double sum = 0;
    for (Product product in products) {
      sum += product.sum!;
      Item item = productToItem(product);
      saveReceiptModel.items!.add(item);
    }
    saveReceiptModel.sum = sum;
    CustomResponse responseData =
        await createReceiptService.saveReceipt(saveReceiptModel);
    loading.value = false;
    if (responseData.status == Status.COMPLETED) {
      success.value = true;
      uploadedReceiptId.value = responseData.data;
    } else {
      success.value = false;
    }
  }
}

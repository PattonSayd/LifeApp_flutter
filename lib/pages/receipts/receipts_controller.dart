import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/receipts/receipt_response.dart';
import 'package:lifeapp/pages/receipts/receipts_service.dart';

class ReceiptsController extends GetxController {
  ReceiptsService receiptsService = ReceiptsService();
  RxBool loading = true.obs;
  RxBool nextPageLoading = false.obs;
  Rxn<ReceiptResponse> receiptResponse = Rxn();
  RxInt page = 0.obs;

  void getAll() async {
    if (page == 0) {
      loading.value = true;
    }else{
      nextPageLoading.value = true;
    }
    CustomResponse customResponse = await receiptsService.getAll(
        receiptResponse.value == null
            ? null
            : receiptResponse.value!.nextPageUrl);

    loading.value = false;
    nextPageLoading.value = false;

    if (customResponse.status == Status.COMPLETED) {
      if (page.value == 0) {
        receiptResponse.value = customResponse.data;
      } else {
        ReceiptResponse nextPageData = customResponse.data;
        receiptResponse.value!.items = [
          ...receiptResponse.value!.items!,
          ...nextPageData.items!
        ];
        receiptResponse.value!.nextPageUrl = nextPageData.nextPageUrl;
        receiptResponse.refresh();
      }
    }
  }
}

import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/vat_receipt_history/receipts_history/vat_receipt.dart';
import 'package:lifeapp/pages/vat_receipt_history/receipts_history/vat_receipt_history_service.dart';

class VatReceiptHistoryController extends GetxController {
  final VatReceiptHistoryService _vatReceiptHistoryService =
      VatReceiptHistoryService();
  Rxn<VatReceiptHistory> vatReceiptHistory = Rxn();
  RxBool initialLoading = true.obs;
  RxBool nextPageLoading = false.obs;
  int currentPage = 0;
  int lastDataLength = 0;

  void getReceipts(String cookie) async {
    if (currentPage == 0) {
      initialLoading.value = true;
    } else {
      nextPageLoading.value = true;
    }

    CustomResponse customResponse =
        await _vatReceiptHistoryService.getAll(cookie, currentPage);

    initialLoading.value = false;
    nextPageLoading.value = false;

    if (customResponse.status == Status.COMPLETED) {
      if (currentPage == 0) {
        vatReceiptHistory.value = customResponse.data;
        lastDataLength = vatReceiptHistory.value!.data!.length;
      } else {
        VatReceiptHistory vatReceiptHistoryData = customResponse.data;
        lastDataLength = vatReceiptHistoryData.data!.length;
        vatReceiptHistory.value!.data!.addAll(vatReceiptHistoryData.data!);
        vatReceiptHistory.refresh();
      }
    }
  }


}

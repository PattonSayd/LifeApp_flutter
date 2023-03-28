import 'package:get/get.dart';

import '../../../core/network/Response.dart';
import '../receipts_history/vat_receipt.dart';
import '../receipts_history/vat_receipt_history_service.dart';

class VatReceiptController extends GetxController {
  final VatReceiptHistoryService _vatReceiptHistoryService =
      VatReceiptHistoryService();
  RxList<VatReceiptData> receipts = RxList();
  int currentPage = 0;
  RxBool downloadStarted = false.obs;

  Future<void> loadAllReceipts(String cookie) async {
    downloadStarted.value = true;
    CustomResponse customResponse =
        await _vatReceiptHistoryService.getAll(cookie, currentPage);
    if (customResponse.status == Status.COMPLETED) {
      VatReceiptHistory vatReceiptHistoryData = customResponse.data;
      receipts.addAll(vatReceiptHistoryData.data!);
      currentPage++;
      int lastLoaded = vatReceiptHistoryData.data!.length;
      if (lastLoaded == 50) {
        await loadAllReceipts(cookie);
      } else {
        downloadStarted.value = false;
      }
    }
  }
}

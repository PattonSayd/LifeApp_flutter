import 'package:get/get.dart';

class WebViewController extends GetxController{
  RxBool receiptLoaded = false.obs;

  void updateReceiptLoaded(){
    receiptLoaded.value = true;
  }
}
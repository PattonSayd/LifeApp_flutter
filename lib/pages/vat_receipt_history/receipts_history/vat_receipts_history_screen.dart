import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:lifeapp/pages/vat_receipt_history/receipts_history/vat_receipt.dart';
import 'package:lifeapp/pages/vat_receipt_history/receipts_history/vat_receipt_history_controller.dart';

import '../../../constants/colors.dart';

class VatReceiptsHistoryScreen extends StatefulWidget {
  VatReceiptsHistoryScreen({Key? key, this.cookie}) : super(key: key);
  final String? cookie;

  @override
  State<VatReceiptsHistoryScreen> createState() =>
      _VatReceiptsHistoryScreenState();
}

class _VatReceiptsHistoryScreenState extends State<VatReceiptsHistoryScreen> {
  final VatReceiptHistoryController _controller =
      Get.put(VatReceiptHistoryController());
  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    _controller.getReceipts(widget.cookie!);
    scrollController = new ScrollController()..addListener(_scrollListener);
  }

  _scrollListener() {
    if (scrollController!.position.extentAfter <= 0 &&
        _controller.lastDataLength == 50) {
      _controller.currentPage++;
      _controller.getReceipts(widget.cookie!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<VatReceiptHistoryController>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => _controller.initialLoading.value
                ? Center(child: CircularProgressIndicator.adaptive())
                : ListView.builder(
                    controller: scrollController,
                    itemCount: _controller.vatReceiptHistory.value != null
                        ? _controller.vatReceiptHistory.value!.data!.length
                        : 0,
                    itemBuilder: (context, index) {
                      VatReceiptData vatReceiptData =
                          _controller.vatReceiptHistory.value!.data![index];
                      return ReceiptItem(
                        vatReceiptData: vatReceiptData,
                      );
                    })),
          ),
          Obx(() => _controller.nextPageLoading.value
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator.adaptive(),
                )
              : SizedBox())
        ],
      ),
    ));
  }
}

class ReceiptItem extends StatelessWidget {
  const ReceiptItem({Key? key, this.vatReceiptData}) : super(key: key);

  final VatReceiptData? vatReceiptData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: CustomColors.shadow,
            blurRadius: 4,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultText(
                  vatReceiptData!.fiscalId!,
                  fontSize: 14.csp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 5,
                ),
                defaultText(
                  vatReceiptData!.storeName!,
                  fontSize: 12.csp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              defaultText(vatReceiptData!.buyAmount!.value! + 'AZN',
                  fontWeight: FontWeight.w400),
              SizedBox(
                height: 5,
              ),
              defaultText(
                  DateFormat('yyyy-MM-dd')
                      .format(vatReceiptData!.insertDate!)
                      .toString(),
                  fontWeight: FontWeight.w400),
            ],
          )
        ],
      ),
    );
    ;
  }
}

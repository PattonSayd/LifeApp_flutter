import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../receipts_history/vat_receipt.dart';

class VatReceiptsScreen extends StatefulWidget {
  const VatReceiptsScreen({Key? key, this.receipts}) : super(key: key);

  final List<VatReceiptData>? receipts;

  @override
  State<VatReceiptsScreen> createState() => _VatReceiptsScreenState();
}

class _VatReceiptsScreenState extends State<VatReceiptsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            body: ListView.builder(
                itemCount: widget.receipts!.length,
                itemBuilder: (context, index) {
                  VatReceiptData vatReceiptData = widget.receipts![index];
                  return ReceiptItem(
                    vatReceiptData: vatReceiptData,
                  );
                })));
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

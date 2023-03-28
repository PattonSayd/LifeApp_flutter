// To parse this JSON data, do
//
//     final vatReceiptHistory = vatReceiptHistoryFromJson(jsonString);

import 'dart:convert';

VatReceiptHistory vatReceiptHistoryFromJson(Map<String, dynamic> str) =>
    VatReceiptHistory.fromJson(str);

String vatReceiptHistoryToJson(VatReceiptHistory data) =>
    json.encode(data.toJson());

class VatReceiptHistory {
  VatReceiptHistory({
    this.code,
    this.data,
  });

  int? code;
  List<VatReceiptData>? data;

  factory VatReceiptHistory.fromJson(Map<String, dynamic> json) =>
      VatReceiptHistory(
        code: json["code"],
        data: List<VatReceiptData>.from(json["data"].map((x) => VatReceiptData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class VatReceiptData {
  VatReceiptData({
    this.id,
    this.fiscalId,
    this.insertDate,
    this.chequeDate,
    this.storeName,
    this.buyAmount,
  });

  int? id;
  String? fiscalId;
  DateTime? insertDate;
  DateTime? chequeDate;
  String? storeName;
  Amount? buyAmount;

  factory VatReceiptData.fromJson(Map<String, dynamic> json) => VatReceiptData(
      id: json["id"],
      fiscalId: json["fiscalId"],
      insertDate: json["insertDate"] != null ? DateTime.parse(json["insertDate"]) : null,
      chequeDate: json["chequeDate"] != null
          ? DateTime.parse(json["chequeDate"])
          : null,
      storeName: json["storeName"] ?? '',
      buyAmount: Amount.fromJson(json["buyAmount"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "fiscalId": fiscalId,
        "insertDate": insertDate!.toIso8601String(),
        "chequeDate": chequeDate!.toIso8601String(),
        "storeName": storeName,
        "buyAmount": buyAmount!.toJson()
      };
}

class Amount {
  Amount({
    this.value,
  });

  String? value;

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        value: json["value"] ?? '0',
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

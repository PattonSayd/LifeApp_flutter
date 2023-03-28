// To parse this JSON data, do
//
//     final receiptResponse = receiptResponseFromJson(jsonString);

import 'dart:convert';

ReceiptResponse receiptResponseFromJson(Map<String, dynamic> str) => ReceiptResponse.fromJson(str);

String receiptResponseToJson(ReceiptResponse data) => json.encode(data.toJson());

class ReceiptResponse {
  ReceiptResponse({
    this.items,
    this.path,
    this.perPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  List<ReceiptItem>? items;
  String? path;
  int? perPage;
  String? nextPageUrl;
  String? prevPageUrl;

  factory ReceiptResponse.fromJson(Map<String, dynamic> json) => ReceiptResponse(
    items: List<ReceiptItem>.from(json["data"].map((x) => ReceiptItem.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    nextPageUrl: json["next_page_url"],
    prevPageUrl: json["prev_page_url"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(items!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "next_page_url": nextPageUrl,
    "prev_page_url": prevPageUrl,
  };
}

class ReceiptItem {
  ReceiptItem({
    this.id,
    this.fiscal,
    this.itemsCount,
    this.sum,
    this.type,
    this.name,
    this.storeTaxNumber,
    this.companyTaxNumber,
    this.storeCheckNumber,
    this.cashier,
    this.storeAddress,
    this.checkDate,
    this.cashBoxTaxNumber,
    this.cashRegisterModelName,
    this.cashRegisterFactoryNumber,
    this.storeName,
    this.companyName,
  });

  int? id;
  String? fiscal;
  int? itemsCount;
  double? sum;
  String? type;
  String? name;
  String? storeTaxNumber;
  String? companyTaxNumber;
  String? storeCheckNumber;
  String? cashier;
  String? storeAddress;
  String? checkDate;
  String? cashBoxTaxNumber;
  String? cashRegisterModelName;
  String? cashRegisterFactoryNumber;
  String? storeName;
  String? companyName;

  factory ReceiptItem.fromJson(Map<String, dynamic> json) => ReceiptItem(
    id: json["id"],
    fiscal: json["fiscal"] ,
    itemsCount: json["items_count"],
    sum: json["sum"] == null ? 0 : json["sum"].toDouble(),
    type: json["type"],
    name: json["name"],
    storeTaxNumber: json["store_tax_number"] ?? 'undefined',
    companyTaxNumber: json["company_tax_number"] ??'undefined',
    storeCheckNumber: json["store_check_number"]??'undefined',
    cashier: json["cashier"] ??'undefined',
    storeAddress: json["store_address"]??'undefined',
    checkDate: json["check_date"]??'undefined',
    cashBoxTaxNumber: json["cash_box_tax_number"] ??'undefined',
    cashRegisterModelName: json["cash_register_model_name"] ??'undefined',
    cashRegisterFactoryNumber: json["cash_register_factory_number"] ??'undefined',
    storeName: json["store_name"] ??'undefined',
    companyName: json["company_name"] ??'undefined',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fiscal": fiscal == null ? null : fiscal,
    "items_count": itemsCount == null ? null : itemsCount,
    "sum": sum == null ? null : sum,
    "name": name,
    "store_tax_number": storeTaxNumber == null ? null : storeTaxNumber,
    "company_tax_number": companyTaxNumber == null ? null : companyTaxNumber,
    "store_check_number": storeCheckNumber,
    "cashier": cashier == null ? null : cashier,
    "store_address": storeAddress == null ? null : storeAddress,
    "check_date": checkDate ,
    "cash_box_tax_number": cashBoxTaxNumber == null ? null : cashBoxTaxNumber,
    "cash_register_model_name": cashRegisterModelName == null ? null : cashRegisterModelName,
    "cash_register_factory_number": cashRegisterFactoryNumber == null ? null : cashRegisterFactoryNumber,
    "store_name": storeName == null ? null : storeName,
    "company_name": companyName == null ? null : companyName,
  };
}



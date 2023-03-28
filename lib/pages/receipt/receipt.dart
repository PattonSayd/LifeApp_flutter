// To parse this JSON data, do
//
//     final receipt = receiptFromJson(jsonString);

import 'dart:collection';
import 'dart:convert';

Receipt receiptFromJson(Map<String, dynamic> str) => Receipt.fromJson(str);

String receiptToJson(Receipt data) => json.encode(data.toJson());

class Receipt {
  Receipt({
    this.exitems,
    this.check,
  });

  List<ReceiptItem>? exitems;
  Check? check;

  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
        exitems: List<ReceiptItem>.from(
            json["exitems"].map((x) => ReceiptItem.fromJson(x))),
        check: Check.fromJson(json["check"]),
      );

  Map<String, dynamic> toJson() => {
        "exitems": List<dynamic>.from(exitems!.map((x) => x.toJson())),
        "check": check!.toJson(),
      };
}

class Check {
  Check({
    this.id,
    this.fiscal,
    this.itemsCount,
    this.sum,
    this.userId,
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
  int? userId;
  String? type;
  String? name;
  String? storeTaxNumber;
  String? companyTaxNumber;
  dynamic? storeCheckNumber;
  String? cashier;
  String? storeAddress;
  DateTime? checkDate;
  String? cashBoxTaxNumber;
  String? cashRegisterModelName;
  String? cashRegisterFactoryNumber;
  String? storeName;
  String? companyName;

  factory Check.fromJson(Map<String, dynamic> json) => Check(
        id: json["id"],
        fiscal: json["fiscal"],
        itemsCount: json["items_count"],
        companyName: json["company_name"] ?? "undefined",
        sum: json["check_date"] != null ? json["sum"].toDouble() : 0,
        userId: json["user_id"],
        type: json["type"],
        name: json["name"],
        storeTaxNumber: json["store_tax_number"] ?? "undefined",
        companyTaxNumber: json["company_tax_number"] ?? "undefined",
        storeCheckNumber: json["store_check_number"] ?? "undefined",
        cashier: json["cashier"] ?? "undefined",
        storeAddress: json["store_address"] ?? "undefined",
        checkDate: json["check_date"] != null
            ? DateTime.parse(json["check_date"])
            : null,
        cashBoxTaxNumber: json["cash_box_tax_number"] ?? "undefined",
        cashRegisterModelName: json["cash_register_model_name"] ?? "undefined",
        cashRegisterFactoryNumber:
            json["cash_register_factory_number"] ?? "undefined",
        storeName: json["store_name"] ?? "undefined",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fiscal": fiscal,
        "items_count": itemsCount,
        "company_name": companyName,
        "sum": sum,
        "user_id": userId,
        "type": type,
        "name": name,
        "store_tax_number": storeTaxNumber,
        "company_tax_number": companyTaxNumber,
        "store_check_number": storeCheckNumber,
        "cashier": cashier,
        "store_address": storeAddress,
        "check_date": checkDate!.toIso8601String(),
        "cash_box_tax_number": cashBoxTaxNumber,
        "cash_register_model_name": cashRegisterModelName,
        "cash_register_factory_number": cashRegisterFactoryNumber,
        "store_name": storeName,
      };
}

class ReceiptItem {
  ReceiptItem({
    this.id,
    this.itemName,
    this.comment,
    this.itemPrice,
    this.homePage,
    this.published,
    this.itemSum,
    this.itemCount,
    this.mlCategoryId,
    this.fiscalId,
    this.checkId,
    this.userCategoryId,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.tagId,
    this.tag,
    this.probability,
  });

  int? id;
  String? itemName;
  String? comment;
  double? itemPrice;
  dynamic homePage;
  dynamic published;
  double? itemSum;
  int? itemCount;
  int? mlCategoryId;
  String? fiscalId;
  dynamic checkId;
  dynamic userCategoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  double? probability;
  int? tagId;
  TagData? tag;

  factory ReceiptItem.fromJson(Map<String, dynamic> json) => ReceiptItem(
        id: json["id"],
        itemName: json["item_name"],
        comment: json["comment"],
        itemPrice: json["item_price"].toDouble(),
        homePage: json["home_page"],
        published: json["published"],
        itemSum: json["item_sum"] != null ? json["item_sum"].toDouble() : 0,
        itemCount: json["item_count"] ?? 1,
        mlCategoryId: json["ml_category_id"] ?? 0,
        fiscalId: json["fiscal_id"],
        checkId: json["check_id"],
        userCategoryId: json["user_category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        tagId: json["tag_id"],
        tag: json["tag"] != null ? TagData.fromJson(json["tag"]) : null,
        probability:
            json["probability"] != null ? json["probability"].toDouble() : 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "comment": comment,
        "item_price": itemPrice,
        "home_page": homePage,
        "published": published,
        "item_sum": itemSum,
        "item_count": itemCount,
        "ml_category_id": mlCategoryId,
        "fiscal_id": fiscalId,
        "check_id": checkId,
        "user_category_id": userCategoryId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "user_id": userId,
        "tag_id": tagId,
        "probability": probability,
      };
}

class TagData {
  TagData({
    this.id,
    this.name,
    this.comment,
  });

  int? id;
  String? name;
  String? comment;

  factory TagData.fromJson(Map<String, dynamic> json) => TagData(
        id: json["id"],
        name: json["name"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "comment": comment,
      };
}

// To parse this JSON data, do
//
//     final manualCost = manualCostFromJson(jsonString);

import 'dart:convert';

List<ManualCost> manualCostFromJson(String str) => List<ManualCost>.from(json.decode(str).map((x) => ManualCost.fromJson(x)));

String manualCostToJson(List<ManualCost> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ManualCost {
  ManualCost({
    this.id,
    this.data,
  });

  int? id;
  Data? data;

  factory ManualCost.fromJson(Map<String, dynamic> json) => ManualCost(
    id: json["id"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.itemName,
    this.itemCount,
    this.itemSum,
    this.userCategoryId,
    this.comment,
    this.itemPrice,
  });

  String? itemName;
  String? itemCount;
  String? itemSum;
  int? userCategoryId;
  String? comment;
  String? itemPrice;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    itemName: json["item_name"],
    itemCount: json["item_count"],
    itemSum: json["item_sum"],
    userCategoryId: json["user_category_id"],
    comment: json["comment"],
    itemPrice: json["item_price"],
  );

  Map<String, dynamic> toJson() => {
    "item_name": itemName,
    "item_count": itemCount,
    "item_sum": itemSum,
    "user_category_id": userCategoryId,
    "comment": comment,
    "item_price": itemPrice,
  };
}

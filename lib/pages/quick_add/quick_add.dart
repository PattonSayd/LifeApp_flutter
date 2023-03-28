// To parse this JSON data, do
//
//     final quickAdd = quickAddFromJson(jsonString);

import 'dart:convert';

List<QuickAdd> quickAddFromJson(List<dynamic> data) => List<QuickAdd>.from(data.map((x) => QuickAdd.fromJson(x)));

String quickAddToJson(QuickAdd data) => json.encode(data.toJson());

class QuickAdd {
  QuickAdd({
    this.id,
    this.itemName,
    this.itemPrice,
    this.tagId,
  });

  int? id;
  String? itemName;
  double? itemPrice;
  int? tagId;

  factory QuickAdd.fromJson(Map<String, dynamic> json) => QuickAdd(
    id: json["id"],
    itemName: json["item_name"],
    tagId: json["tag_id"],
    itemPrice: json["item_price"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_name": itemName,
    "item_price": itemPrice,
    "tag_id": tagId,
  };
}

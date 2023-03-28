// To parse this JSON data, do
//
//     final subCategoryCostItemResponse = subCategoryCostItemResponseFromJson(jsonString);

import 'dart:convert';

SubCategoryCostItemResponse subCategoryCostItemResponseFromJson(
        Map<String, dynamic> str) =>
    SubCategoryCostItemResponse.fromJson(str);

String subCategoryCostItemResponseToJson(SubCategoryCostItemResponse data) =>
    json.encode(data.toJson());

class SubCategoryCostItemResponse {
  SubCategoryCostItemResponse({
    this.items,
    this.path,
    this.perPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  List<SubCategoryCostItem>? items;
  String? path;
  int? perPage;
  String? nextPageUrl;
  String? prevPageUrl;

  factory SubCategoryCostItemResponse.fromJson(Map<String, dynamic> json) =>
      SubCategoryCostItemResponse(
        items: json["data"] != null
            ? List<SubCategoryCostItem>.from(
                json["data"].map((x) => SubCategoryCostItem.fromJson(x)))
            : [],
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

class SubCategoryCostItem {
  SubCategoryCostItem(
      {this.id,
      this.itemName,
      this.comment,
      this.itemPrice,
      this.itemSum,
      this.itemCount,
      this.mlCategoryId,
      this.fiscalId,
      this.checkId,
      this.userCategoryId,
      this.probability,
      this.tagId,
      this.check});

  int? id;
  String? itemName;
  String? comment;
  double? itemPrice;
  double? itemSum;
  int? itemCount;
  String? mlCategoryId;
  String? fiscalId;
  int? checkId;
  int? userCategoryId;
  double? probability;
  int? tagId;
  Check? check;

  factory SubCategoryCostItem.fromJson(Map<String, dynamic> json) =>
      SubCategoryCostItem(
          id: json["id"],
          itemName: json["item_name"],
          comment: json["comment"],
          itemPrice:
              json["item_price"] != null ? json["item_price"].toDouble() : 0,
          itemSum: json["item_sum"] != null ? json["item_sum"].toDouble() : 0,
          itemCount: json["item_count"],
          mlCategoryId: json["ml_category_id"],
          fiscalId: json["fiscal_id"],
          checkId: json["check_id"],
          userCategoryId: json["user_category_id"],
          probability:
              json["probability"] != null ? json["probability"].toDouble() : 0,
          tagId: json["tag_id"],
          check: json["check"] != null ? Check.fromJson(json["check"]) : null);

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "comment": comment == null ? null : comment,
        "item_price": itemPrice,
        "item_sum": itemSum,
        "item_count": itemCount,
        "ml_category_id": mlCategoryId,
        "fiscal_id": fiscalId == null ? null : fiscalId,
        "check_id": checkId,
        "user_category_id": userCategoryId == null ? null : userCategoryId,
        "probability": probability,
        "tag_id": tagId,
      };
}

Check checkFromJson(String str) => Check.fromJson(json.decode(str));

String checkToJson(Check data) => json.encode(data.toJson());

class Check {
  Check({
    this.id,
    this.fiscal,
    this.type,
    this.companyName,
    this.storeName,
  });

  int? id;
  String? fiscal;
  String? type;
  String? companyName;
  String? storeName;

  factory Check.fromJson(Map<String, dynamic> json) => Check(
        id: json["id"],
        fiscal: json["fiscal"],
        type: json["type"],
        companyName: json["company_name"] ?? "",
        storeName: json["store_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fiscal": fiscal,
        "type": type,
        "company_name": storeName,
        "store_name": storeName,
      };
}

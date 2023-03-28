TagCostItemsResponse tagCostItemsFromJson(Map<String, dynamic> str) =>
    TagCostItemsResponse.fromJson(str);

class TagCostItemsResponse {
  TagCostItemsResponse({
    this.items,
    this.path,
    this.perPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  List<TagCostItem>? items;
  String? path;
  int? perPage;
  String? nextPageUrl;
  String? prevPageUrl;

  factory TagCostItemsResponse.fromJson(Map<String, dynamic> json) =>
      TagCostItemsResponse(
        items: List<TagCostItem>.from(
            json["data"].map((x) => TagCostItem.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
      );
}

class TagCostItem {
  TagCostItem({
    this.id,
    this.itemName,
    this.comment,
    this.itemPrice,
    this.itemSum,
    this.itemCount,
    this.mlCategoryId,
    this.fiscalId,
    this.checkId,
    this.probability,
    this.tagId,
  });

  int? id;
  String? itemName;
  String? comment;
  double? itemPrice;
  double? itemSum;
  int? itemCount;
  String? mlCategoryId;
  String? fiscalId;
  int? checkId;
  double? probability;
  int? tagId;

  factory TagCostItem.fromJson(Map<String, dynamic> json) => TagCostItem(
        id: json["id"],
        itemName: json["item_name"],
        comment: json["comment"],
        itemPrice: json["item_price"].toDouble(),
        itemSum: json["item_sum"].toDouble(),
        itemCount: json["item_count"],
        mlCategoryId: json["ml_category_id"],
        fiscalId: json["fiscal_id"],
        checkId: json["check_id"],
        probability: json["probability"].toDouble(),
        tagId: json["tag_id"],
      );
}

import 'package:lifeapp/pages/create_receipt/examine_receipt/models/product.dart';

class SaveReceipt {
  String? fiscal;
  String? signature;
  String? date;
  double? sum;
  List<Item>? items;

  Map<String, dynamic> toJson() => {
        "fiscal": fiscal,
        "signature": signature,
        "checked_at": date,
        "sum": sum,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  String? itemName;
  double? itemCount;
  double? itemPrice;
  int? categoryId;
  int? subCategoryId;
  int? tagId;
  double? probability;

  Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "item_count": itemCount,
        "item_price": itemPrice,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "tag_id": tagId,
        "probability": probability
      };
}

Item productToItem(Product product) {
  Item item = Item();
  item.itemName = product.name;
  item.itemCount = product.count;
  item.itemPrice = product.price;
  item.categoryId = product.categoryId;
  item.subCategoryId = product.subCategoryId;
  item.probability = product.probability;
  item.tagId = product.tagId;
  return item;
}

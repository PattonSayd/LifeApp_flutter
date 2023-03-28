class Product {
  Product(
      {this.name,
      this.count,
      this.price,
      this.sum,
      this.categoryId,
      this.subCategoryId,
      this.category});

  String? name;
  double? count;
  double? price;
  double? sum;
  String? category;
  int? categoryId;
  int? subCategoryId;
  double? probability;
  int? tagId;
  String? tag;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      name: json["name"],
      count: json["count"].toDouble(),
      price: json["price"].toDouble(),
      sum: json["sum"].toDouble(),
      category: json["category"]);

}

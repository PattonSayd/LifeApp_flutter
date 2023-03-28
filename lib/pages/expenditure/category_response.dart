// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(List<dynamic> str) =>
    List<Category>.from(str.map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.parentId,
    this.name,
    this.importLabel,
  });

  int? id;
  String? parentId;
  String? name;
  String? importLabel;
  String? label;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        importLabel: json["import_label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "import_label": importLabel,
        "label": label,
      };
}

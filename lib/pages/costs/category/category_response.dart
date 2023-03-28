// To parse this JSON data, do
//
//     final cost = costFromJson(jsonString);

import 'dart:convert';

List<CategoryResponse> categoryFromJson(List<dynamic> str) => List<CategoryResponse>.from(str.map((x) => CategoryResponse.fromJson(x)));

String costToJson(List<CategoryResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryResponse {
  CategoryResponse({
    this.id,
    this.parentId,
    this.name,
    this.importLabel,
    this.label,
  });

  int? id;
  String? parentId;
  String? name;
  String? importLabel;
  String? label;
  double? sum;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
    id: json["id"],
    parentId: json["parent_id"],
    name: json["name"],
    importLabel: json["import_label"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "name": name,
    "import_label": importLabel,
    "label": label,
  };
}

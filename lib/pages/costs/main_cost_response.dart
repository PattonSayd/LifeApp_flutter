// To parse this JSON data, do
//
//     final cost = costFromJson(jsonString);

import 'dart:convert';

List<CostResponse> costFromJson(List<dynamic> str) => List<CostResponse>.from(str.map((x) => CostResponse.fromJson(x)));

String costToJson(List<CostResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CostResponse {
  CostResponse({
    this.id,
    this.parentId,
    this.name,
    this.importLabel,
    this.label,
    this.parentExitemsSumItemSum,
  });

  int? id;
  String? parentId;
  String? name;
  String? importLabel;
  String? label;
  double? parentExitemsSumItemSum;

  factory CostResponse.fromJson(Map<String, dynamic> json) => CostResponse(
    id: json["id"],
    parentId: json["parent_id"],
    name: json["name"],
    importLabel: json["import_label"],
    label: json["label"],
    parentExitemsSumItemSum: json["parent_exitems_sum_item_sum"] == null ? 0 : json["parent_exitems_sum_item_sum"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "name": name,
    "import_label": importLabel,
    "label": label,
    "parent_exitems_sum_item_sum": parentExitemsSumItemSum == null ? null : parentExitemsSumItemSum,
  };
}

import 'dart:convert';

List<SubCategoryCostResponse> subCategoryCostResponseFromJson(List<dynamic> str) =>
    List<SubCategoryCostResponse>.from(
        str.map((x) => SubCategoryCostResponse.fromJson(x)));

String subCategoryCostResponseToJson(List<SubCategoryCostResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategoryCostResponse {
  SubCategoryCostResponse({
    this.id,
    this.name,
    this.importLabel,
    this.label,
    this.childExitemsSumItemSum,
  });

  int? id;
  String? name;
  String? importLabel;
  String? label;
  double? childExitemsSumItemSum;

  factory SubCategoryCostResponse.fromJson(Map<String, dynamic> json) =>
      SubCategoryCostResponse(
        id: json["id"],
        name: json["name"],
        importLabel: json["import_label"],
        label: json["label"],
        childExitemsSumItemSum: json["child_exitems_sum_item_sum"] == null
            ? 0
            : json["child_exitems_sum_item_sum"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "import_label": importLabel,
        "label": label,
        "child_exitems_sum_item_sum":
            childExitemsSumItemSum == null ? null : childExitemsSumItemSum,
      };
}

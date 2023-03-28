// To parse this JSON data, do
//
//     final tagCostsResponse = tagCostsResponseFromJson(jsonString);

import 'dart:convert';

List<TagCostsResponse> tagCostsResponseFromJson(List<dynamic> str) =>
    List<TagCostsResponse>.from(str.map((x) => TagCostsResponse.fromJson(x)));

String tagCostsResponseToJson(List<TagCostsResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TagCostsResponse {
  TagCostsResponse({
    this.id,
    this.name,
    this.comment,
    this.exitemsSumItemSum,
  });

  int? id;
  String? name;
  String? comment;
  double? exitemsSumItemSum;

  factory TagCostsResponse.fromJson(Map<String, dynamic> json) =>
      TagCostsResponse(
        id: json["id"],
        name: json["name"] ?? "",
        comment: json["comment"] ?? "",
        exitemsSumItemSum: json["exitems_sum_item_sum"] != null
            ? json["exitems_sum_item_sum"].toDouble()
            : 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "comment": comment == null ? null : comment,
        "exitems_sum_item_sum": exitemsSumItemSum,
      };
}

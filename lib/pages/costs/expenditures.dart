// To parse this JSON data, do
//
//     final expenditure = expenditureFromJson(jsonString);

import 'dart:convert';

ExpenditureResponse expenditureFromJson(Map<String, dynamic> str) =>
    ExpenditureResponse.fromJson(str);

String expenditureToJson(ExpenditureResponse data) =>
    json.encode(data.toJson());

class ExpenditureResponse {
  ExpenditureResponse({
    this.categoryExpenditures,
    this.tagExpenditures,
  });

  List<Expenditure>? categoryExpenditures;
  List<Expenditure>? tagExpenditures;

  factory ExpenditureResponse.fromJson(Map<String, dynamic> json) =>
      ExpenditureResponse(
        categoryExpenditures: List<Expenditure>.from(
            json["category_consumptions"].map((x) => Expenditure.fromJson(x))),
        tagExpenditures: List<Expenditure>.from(
            json["tag_consuptions"].map((x) => Expenditure.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_consumptions":
            List<dynamic>.from(categoryExpenditures!.map((x) => x.toJson())),
        "tag_consuptions":
            List<dynamic>.from(tagExpenditures!.map((x) => x.toJson())),
      };
}

class Expenditure {
  Expenditure({
    this.id,
    this.name,
    this.type,
    this.limit,
    this.startDate,
    this.endDate,
    this.periodType,
    this.tagId,
    this.categoryId,
  });

  int? id;
  String? name;
  String? type;
  int? limit;
  String? startDate;
  String? endDate;
  String? periodType;
  int? tagId;
  int? categoryId;

  factory Expenditure.fromJson(Map<String, dynamic> json) => Expenditure(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        limit: json["limit"] == null ? null : json["limit"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        periodType: json["period_type"],
        tagId: json["tag_id"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "limit": limit == null ? null : limit,
        "start_date": startDate,
        "end_date": endDate,
        "period_type": periodType,
        "tag_id": tagId,
        "category_id": categoryId,
      };
}

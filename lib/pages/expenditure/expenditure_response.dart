// To parse this JSON data, do
//
//     final expenditureResponse = expenditureResponseFromJson(jsonString);

import 'dart:convert';

ExpenditureResponse expenditureResponseFromJson(Map<String, dynamic> str) =>
    ExpenditureResponse.fromJson(str);

String expenditureResponseToJson(ExpenditureResponse data) =>
    json.encode(data.toJson());

class ExpenditureResponse {
  ExpenditureResponse({
    this.expenditures,
    this.path,
    this.perPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  List<Expenditure>? expenditures;
  String? path;
  int? perPage;
  String? nextPageUrl;
  String? prevPageUrl;

  factory ExpenditureResponse.fromJson(Map<String, dynamic> json) =>
      ExpenditureResponse(
        expenditures: List<Expenditure>.from(
            json["data"].map((x) => Expenditure.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(expenditures!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
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
  DateTime? startDate;
  DateTime? endDate;
  String? periodType;
  int? tagId;
  int? categoryId;

  factory Expenditure.fromJson(Map<String, dynamic> json) => Expenditure(
        id: json["id"],
        name: json["name"],
        type: json["type"] == null ? null : json["type"],
        limit: json["limit"] == null ? null : json["limit"],
        startDate: json["start_date"] != null
            ? DateTime.parse(json["start_date"])
            : null,
        endDate:
            json["end_date"] != null ? DateTime.parse(json["end_date"]) : null,
        periodType: json["period_type"],
        tagId: json["tag_id"] == null ? null : json["tag_id"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type == null ? null : type,
        "limit": limit == null ? null : limit,
        "start_date": startDate,
        "end_date": endDate,
        "period_type": periodType,
        "tag_id": tagId == null ? null : tagId,
        "category_id": categoryId,
      };
}

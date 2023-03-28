// To parse this JSON data, do
//
//     final fundResponseDto = fundResponseDtoFromJson(jsonString);

import 'dart:convert';

FundResponseDto fundResponseDtoFromJson(Map<String, dynamic> str) =>
    FundResponseDto.fromJson(str);

String fundResponseDtoToJson(FundResponseDto data) =>
    json.encode(data.toJson());

class FundResponseDto {
  FundResponseDto({
    this.funds,
    this.path,
    this.perPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  List<Fund>? funds;
  String? path;
  int? perPage;
  String? nextPageUrl;
  String? prevPageUrl;

  factory FundResponseDto.fromJson(Map<String, dynamic> json) =>
      FundResponseDto(
        funds: List<Fund>.from(json["data"].map((x) => Fund.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(funds!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
      };
}

class Fund {
  Fund({
    this.id,
    this.balance,
    this.type,
    this.identityNumber,
    this.name,
  });

  int? id;
  int? balance;
  String? type;
  int? identityNumber;
  String? name;

  factory Fund.fromJson(Map<String, dynamic> json) => Fund(
        id: json["id"],
        balance: json["balance"],
        type: json["type"],
        identityNumber: json["identity_number"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "balance": balance,
        "type": type,
        "identity_number": identityNumber,
        "name": name,
      };
}

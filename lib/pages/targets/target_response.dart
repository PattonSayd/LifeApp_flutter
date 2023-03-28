// To parse this JSON data, do
//
//     final targetResponseDto = targetResponseDtoFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

TargetResponseDto targetResponseDtoFromJson(Map<String, dynamic> str) =>
    TargetResponseDto.fromJson(str);

String targetResponseDtoToJson(TargetResponseDto data) =>
    json.encode(data.toJson());

class TargetResponseDto {
  TargetResponseDto({
    this.targets,
    this.path,
    this.perPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  List<Target>? targets;
  String? path;
  int? perPage;
  String? nextPageUrl;
  String? prevPageUrl;

  factory TargetResponseDto.fromJson(Map<String, dynamic> json) =>
      TargetResponseDto(
        targets: List<Target>.from(json["data"].map((x) => Target.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(targets!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
      };
}

List<Target> targetFromJson(List<dynamic> str) =>
    List<Target>.from(str.map((x) => Target.fromJson(x)));

class Target {
  Target(
      {this.id,
      this.name,
      this.startDate,
      this.endDate,
      this.sum,
      this.comment,
      this.totalSum});

  int? id;
  String? name;
  String? startDate;
  String? endDate;
  double? sum;
  String? comment;
  double? totalSum;

  factory Target.fromJson(Map<String, dynamic> json) => Target(
        id: json["id"],
        name: json["name"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        sum: json["sum"] != null ? double.parse(json["sum"].toString()) : 0,
        comment: json["comment"],
        totalSum: json["goalinput_sum_sum"] != null ? double.parse(json["goalinput_sum_sum"].toString()) : 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start_date": startDate,
        "end_date": endDate,
        "sum": sum,
        "comment": comment,
      };
}

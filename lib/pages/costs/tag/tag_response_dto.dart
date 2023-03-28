// To parse this JSON data, do
//
//     final tagResponseDto = tagResponseDtoFromJson(jsonString);

import 'dart:convert';

TagResponseDto tagResponseDtoFromJson(Map<String, dynamic>  str) => TagResponseDto.fromJson(str);

String tagResponseDtoToJson(TagResponseDto data) => json.encode(data.toJson());

class TagResponseDto {
  TagResponseDto({
    this.tags,
    this.path,
    this.perPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  List<Tag>? tags;
  String? path;
  int? perPage;
  String? nextPageUrl;
  String? prevPageUrl;

  factory TagResponseDto.fromJson(Map<String, dynamic> json) => TagResponseDto(
    tags: List<Tag>.from(json["data"].map((x) => Tag.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    nextPageUrl: json["next_page_url"],
    prevPageUrl: json["prev_page_url"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(tags!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "next_page_url": nextPageUrl,
    "prev_page_url": prevPageUrl,
  };
}

class Tag {
  Tag({
    this.id,
    this.name,
    this.comment,
  });

  int? id;
  String? name;
  String? comment;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    name: json["name"],
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "comment": comment,
  };
}

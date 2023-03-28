// To parse this JSON data, do
//
//     final bonusCard = bonusCardFromJson(jsonString);

import 'dart:convert';

List<BonusCard> bonusCardFromJson(List<dynamic> str) => List<BonusCard>.from(str.map((x) => BonusCard.fromJson(x)));

String bonusCardToJson(List<BonusCard> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BonusCard {
  BonusCard({
    this.id,
    this.vendor,
    this.code,
    this.userId
  });

  int? id;
  String? vendor;
  String? code;
  int? userId;

  factory BonusCard.fromJson(Map<String, dynamic> json) => BonusCard(
    id: json["id"],
    vendor: json["vendor"],
    code: json["code"],
    userId: json["user_id"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor": vendor,
    "code": code,
    "user_id": userId
  };
}

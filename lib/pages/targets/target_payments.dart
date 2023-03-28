// To parse this JSON data, do
//
//     final goalPayment = goalPaymentFromJson(jsonString);

import 'dart:convert';

List<GoalPayment> goalPaymentFromJson(List<dynamic> str) =>
    List<GoalPayment>.from(str.map((x) => GoalPayment.fromJson(x)));

String goalPaymentToJson(List<GoalPayment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GoalPayment {
  GoalPayment({
    this.id,
    this.from,
    this.to,
    this.sum,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? from;
  int? to;
  double? sum;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GoalPayment.fromJson(Map<String, dynamic> json) => GoalPayment(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        sum: json["sum"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "from": from, "to": to, "sum": sum};
}

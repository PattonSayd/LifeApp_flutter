// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(Map<String, dynamic> str) => User.fromJson(str);

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({this.work, this.address, this.gender,  this.name});

  String? work;
  String? address;
  String? gender;
  String? name;

  factory User.fromJson(Map<String, dynamic> json) => User(
        work: json["work"],
        address: json["address"],
        gender: json["gender"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "work": work,
        "address": address,
        "gender": gender,
        "name": name,
      };
}

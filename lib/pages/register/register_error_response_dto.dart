import 'dart:convert';

RegisterErrorResponseDto errorFromJson(Map<String, dynamic> str) =>
    RegisterErrorResponseDto.fromJson(str);

String errorToJson(RegisterErrorResponseDto data) => json.encode(data.toJson());

class RegisterErrorResponseDto {
  RegisterErrorResponseDto({
    this.message,
    this.errors,
  });

  String? message;
  Errors? errors;

  factory RegisterErrorResponseDto.fromJson(Map<String, dynamic> json) =>
      RegisterErrorResponseDto(
        message: json["message"],
        errors: Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errors": errors!.toJson(),
      };
}

class Errors {
  Errors({
    this.name,
    this.email,
    this.password,
    this.phone,
  });

  List<String>? name;
  List<String>? email;
  List<String>? password;
  List<String>? phone;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
      name: json["name"] != null
          ? List<String>.from(json["name"].map((x) => x))
          : null,
      email: json["email"] != null
          ? List<String>.from(json["email"].map((x) => x))
          : null,
      password: json["password"] != null
          ? List<String>.from(json["password"].map((x) => x))
          : null,
      phone: json["phone"] != null
          ? List<String>.from(json["phone"].map((x) => x))
          : null);

  Map<String, dynamic> toJson() => {
        "name": List<dynamic>.from(name!.map((x) => x)),
        "email": List<dynamic>.from(email!.map((x) => x)),
        "password": List<dynamic>.from(password!.map((x) => x)),
        "phone": List<dynamic>.from(phone!.map((x) => x)),
      };
}

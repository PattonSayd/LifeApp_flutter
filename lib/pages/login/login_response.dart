// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(Map<String, dynamic> json) => LoginResponse.fromJson(json);

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        this.accessToken,
        this.tokenType,
        this.emailVerified
    });

    String?  accessToken;
    String? tokenType;
    int? emailVerified;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        emailVerified: json["email_verified"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "email_verified": emailVerified,
    };
}

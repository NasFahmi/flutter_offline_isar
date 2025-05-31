// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'login_response_model.g.dart';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

@JsonSerializable()
class LoginResponseModel {
    @JsonKey(name: "accessToken")
    String accessToken;
    @JsonKey(name: "refreshToken")
    String refreshToken;

    LoginResponseModel({
        required this.accessToken,
        required this.refreshToken,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

    Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

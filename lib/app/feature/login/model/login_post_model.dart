// To parse this JSON data, do
//
//     final loginPostModel = loginPostModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'login_post_model.g.dart';

LoginPostModel loginPostModelFromJson(String str) => LoginPostModel.fromJson(json.decode(str));

String loginPostModelToJson(LoginPostModel data) => json.encode(data.toJson());

@JsonSerializable()
class LoginPostModel {
    @JsonKey(name: "username")
    String username;
    @JsonKey(name: "password")
    String password;

    LoginPostModel({
        required this.username,
        required this.password,
    });

    factory LoginPostModel.fromJson(Map<String, dynamic> json) => _$LoginPostModelFromJson(json);

    Map<String, dynamic> toJson() => _$LoginPostModelToJson(this);
}

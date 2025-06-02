import 'package:json_annotation/json_annotation.dart';
part 'get_user_detial_model.g.dart';
@JsonSerializable()
class GetDetailUserModel {
    @JsonKey(name: "id")
    String id;
    @JsonKey(name: "name")
    String name;
    @JsonKey(name: "username")
    String username;
    @JsonKey(name: "password")
    String password;
    @JsonKey(name: "refreshToken")
    String refreshToken;
    @JsonKey(name: "createdAt")
    DateTime createdAt;
    @JsonKey(name: "updatedAt")
    DateTime updatedAt;

    GetDetailUserModel({
        required this.id,
        required this.name,
        required this.username,
        required this.password,
        required this.refreshToken,
        required this.createdAt,
        required this.updatedAt,
    });

    factory GetDetailUserModel.fromJson(Map<String, dynamic> json) => _$GetDetailUserModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetDetailUserModelToJson(this);
}

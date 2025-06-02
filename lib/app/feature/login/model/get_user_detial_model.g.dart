// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_detial_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDetailUserModel _$GetDetailUserModelFromJson(Map<String, dynamic> json) =>
    GetDetailUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      refreshToken: json['refreshToken'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$GetDetailUserModelToJson(GetDetailUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'password': instance.password,
      'refreshToken': instance.refreshToken,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

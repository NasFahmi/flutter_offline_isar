// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_book_by_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookByIdModel _$GetBookByIdModelFromJson(Map<String, dynamic> json) =>
    GetBookByIdModel(
      status: (json['status'] as num).toInt(),
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
    );

Map<String, dynamic> _$GetBookByIdModelToJson(GetBookByIdModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'description': instance.description,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

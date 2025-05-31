// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListBookModel _$GetListBookModelFromJson(Map<String, dynamic> json) =>
    GetListBookModel(
      status: (json['status'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$GetListBookModelToJson(GetListBookModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      publishedAt: json['publishedAt'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'description': instance.description,
      'publishedAt': instance.publishedAt,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

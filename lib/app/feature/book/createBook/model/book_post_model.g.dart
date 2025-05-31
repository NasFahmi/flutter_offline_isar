// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookPostModel _$BookPostModelFromJson(Map<String, dynamic> json) =>
    BookPostModel(
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$BookPostModelToJson(BookPostModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'description': instance.description,
      'publishedAt': instance.publishedAt,
    };

// To parse this JSON data, do
//
//     final getListBookModel = getListBookModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'get_list_book_model.g.dart';
@JsonSerializable()
class GetListBookModel {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "data")
    List<Datum> data;
    @JsonKey(name: "message")
    String message;

    GetListBookModel({
        required this.status,
        required this.data,
        required this.message,
    });

    factory GetListBookModel.fromJson(Map<String, dynamic> json) => _$GetListBookModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetListBookModelToJson(this);
}

@JsonSerializable()
class Datum {
    @JsonKey(name: "id")
    String id;
    @JsonKey(name: "title")
    String title;
    @JsonKey(name: "author")
    String author;
    @JsonKey(name: "description")
    String description;
    @JsonKey(name: "publishedAt")
    String publishedAt;
    @JsonKey(name: "userId")
    String userId;
    @JsonKey(name: "createdAt")
    DateTime createdAt;
    @JsonKey(name: "updatedAt")
    DateTime updatedAt;

    Datum({
        required this.id,
        required this.title,
        required this.author,
        required this.description,
        required this.publishedAt,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

    Map<String, dynamic> toJson() => _$DatumToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'get_book_by_id_model.g.dart';
@JsonSerializable()
class GetBookByIdModel {
    @JsonKey(name: "status")
    int status;
    @JsonKey(name: "data")
    Data data;
    @JsonKey(name: "message")
    String message;

    GetBookByIdModel({
        required this.status,
        required this.data,
        required this.message,
    });

    factory GetBookByIdModel.fromJson(Map<String, dynamic> json) => _$GetBookByIdModelFromJson(json);

    Map<String, dynamic> toJson() => _$GetBookByIdModelToJson(this);
}

@JsonSerializable()
class Data {
    @JsonKey(name: "id")
    String id;
    @JsonKey(name: "title")
    String title;
    @JsonKey(name: "author")
    String author;
    @JsonKey(name: "description")
    String description;
    @JsonKey(name: "publishedAt")
    DateTime publishedAt;
    @JsonKey(name: "userId")
    String userId;
    @JsonKey(name: "createdAt")
    DateTime createdAt;
    @JsonKey(name: "updatedAt")
    DateTime updatedAt;

    Data({
        required this.id,
        required this.title,
        required this.author,
        required this.description,
        required this.publishedAt,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    Map<String, dynamic> toJson() => _$DataToJson(this);
}

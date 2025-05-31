
import 'package:json_annotation/json_annotation.dart';
part 'book_post_model.g.dart';
@JsonSerializable()
class BookPostModel {
    @JsonKey(name: "title")
    String title;
    @JsonKey(name: "author")
    String author;
    @JsonKey(name: "description")
    String description;
    @JsonKey(name: "publishedAt")
    String publishedAt;

    BookPostModel({
        required this.title,
        required this.author,
        required this.description,
        required this.publishedAt,
    });

    factory BookPostModel.fromJson(Map<String, dynamic> json) => _$BookPostModelFromJson(json);

    Map<String, dynamic> toJson() => _$BookPostModelToJson(this);
}

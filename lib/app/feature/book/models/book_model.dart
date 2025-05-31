import 'package:isar/isar.dart';
part 'book_model.g.dart';
@Collection()
class BookModel {
  // id local db isar
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? serverId; // UUID dari server
  String? title;
  String? author;
  String? description;
  String? publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
}

import 'package:isar/isar.dart';

import '../../home/model/get_list_book_model.dart' as book;
part 'book_model.g.dart';

@Collection()
class BookModel {
  // Default constructor
  BookModel();

  // id local db isar
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? serverId; // UUID dari server
  String? title;
  String? author;
  String? description;
  String? publishedAt;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  bool isSynced = false;
  // ✅ Konversi dari server model Datum
  factory BookModel.fromServer(book.Datum data) {
    return BookModel()
      ..serverId = data.id
      ..title = data.title
      ..author = data.author
      ..description = data.description
      ..publishedAt = data.publishedAt
      ..userId = data.userId
      ..createdAt = data.createdAt
      ..updatedAt = data.updatedAt;
  }

  // ✅ Konversi kembali ke server DTO jika diperlukan
  book.Datum toServer() {
    return book.Datum(
      id: serverId ?? "",
      title: title ?? "",
      author: author ?? "",
      description: description ?? "",
      publishedAt: publishedAt ?? "",
      userId: userId ?? "",
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}

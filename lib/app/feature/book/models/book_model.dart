import 'package:isar/isar.dart';
import 'package:offline_mode/app/feature/book/detailBook/model/get_book_by_id_model.dart'
    as book_by_id;

import '../../home/model/get_list_book_model.dart' as book;
part 'book_model.g.dart';

@Collection()
class BookLocalModel {
  // Default constructor
  BookLocalModel();

  // id local db isar
  Id id = Isar.autoIncrement;

  String? serverId; // UUID dari server
  String? title;
  String? author;
  String? description;
  String? publishedAt;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  bool isUpdated = false;
  bool isFromServer = false; // flag untuk updated dari server
  bool isSynced = false;
  // ✅ Konversi dari server model Datum
  factory BookLocalModel.fromServerDatum(book.Datum data) {
    return BookLocalModel()
      ..serverId = data.id
      ..title = data.title
      ..isSynced = true
      ..author = data.author
      ..description = data.description
      ..publishedAt = data.publishedAt
      ..userId = data.userId
      ..createdAt = data.createdAt
      ..updatedAt = data.updatedAt;
  }
  // ✅ Konversi dari server model Data untuk get by id
  factory BookLocalModel.fromServerData(book_by_id.Data data) {
    return BookLocalModel()
      ..serverId = data.id
      ..title = data.title
      ..author = data.author
      ..isSynced = true
      ..description = data.description
      ..publishedAt = data.publishedAt as String?
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

import 'package:isar/isar.dart';
part 'sync_queue_model.g.dart';

@Collection()
class SyncQueue  {
  // id local db isar
  Id id = Isar.autoIncrement;

  String? collectionName; // eg: 'Book'
  String? operation; // CREATE, UPDATE, DELETE
  String? payload; // JSON string

  // @Enumerated(EnumType.values,'status')
  @enumerated
  late Status status; // pending, synced, failed
  String? link; // stored link to server
  DateTime? createdAt;
}


enum Status {
  pending,
  synced,
  success,
  failed,
}
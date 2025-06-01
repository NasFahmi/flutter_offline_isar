import 'package:isar/isar.dart';
import 'package:offline_mode/app/database/queueService/model/sync_queue_model.dart';
import 'package:path_provider/path_provider.dart';

import '../feature/book/models/book_model.dart';

class DatabaseService {
  // setiap membuat shcema selalu daftarkan disini
  static late final Isar db;
  static Future<void> setup() async {
    final appDir = await getApplicationDocumentsDirectory();
    db = await Isar.open([BookLocalModelSchema,SyncQueueSchema], inspector: true, directory: appDir.path);
  }
}

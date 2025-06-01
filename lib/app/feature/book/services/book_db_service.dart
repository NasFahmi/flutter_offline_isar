import 'package:isar/isar.dart';
import 'package:offline_mode/app/database/database_service.dart';
import 'package:offline_mode/app/feature/book/services/interface_db_service.dart';

import '../models/book_model.dart';

class BookDbService implements InterfaceDbService<BookLocalModel> {
  @override
  Future<void> clearData() async {
    await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.bookLocalModels.clear();
    });
  }

  @override
  Future<void> createData(BookLocalModel data) async {
    await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.bookLocalModels.put(data);
    });
  }

  @override
  Future<List<BookLocalModel>> getAllData() async {
    return await DatabaseService.db.bookLocalModels.where().findAll();
  }

  @override
  Future<BookLocalModel?> getDataById(String id) async {
    return await DatabaseService.db.bookLocalModels.getByServerId(id);
  }

  @override
  Future<void> saveData(List<BookLocalModel> data) async {
    await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.bookLocalModels.putAll(data);
    });
  }

  @override
  Future<void> updateData(BookLocalModel data) async {
    await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.bookLocalModels.put(data);
    });
  }

  @override
  Future<List<BookLocalModel>> getUnsyncedData() async {
    return await DatabaseService.db.bookLocalModels
        .filter()
        .isSyncedEqualTo(false)
        .findAll();
  }

  @override
  Future<void> clearSyncedData() async {
    await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.bookLocalModels
          .filter()
          .isSyncedEqualTo(true)
          .deleteAll();
    });
  }

  @override
  Future<void> clearUnsyncedData() async {
    await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.bookLocalModels
          .filter()
          .isSyncedEqualTo(false)
          .deleteAll();
    });
  }

  @override
  Future<List<BookLocalModel>> getsyncedData() async {
    return await DatabaseService.db.bookLocalModels
        .filter()
        .isSyncedEqualTo(true)
        .findAll();
  }
}

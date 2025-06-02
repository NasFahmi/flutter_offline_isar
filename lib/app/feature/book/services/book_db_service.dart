import 'package:isar/isar.dart';
import 'package:offline_mode/app/database/database_service.dart';
import 'package:offline_mode/app/feature/book/services/interface_db_service.dart';
import 'package:offline_mode/utils/logger/logger.dart';

import '../models/book_model.dart';

class BookDbService implements InterfaceDbService<BookLocalModel> {
  @override
  Future<void> clearData() async {
    try {
      await DatabaseService.db.writeTxn(() async {
        await DatabaseService.db.bookLocalModels.clear();
      });
    } catch (e) {
      logger.d(e);
    }
  }

  @override
  Future<void> createData(BookLocalModel data) async {
    try {
      await DatabaseService.db.writeTxn(() async {
        await DatabaseService.db.bookLocalModels.put(data);
      });
    } catch (e) {
      logger.d(e);
    }
  }

  @override
  Future<List<BookLocalModel>> getAllData() async {
    return await DatabaseService.db.bookLocalModels.where().findAll();
  }

  @override
  Future<BookLocalModel?> getDataById(String id) async {
    return await DatabaseService.db.bookLocalModels
        .filter()
        .serverIdEqualTo(id)
        .findFirst();
  }

  @override
  Future<void> saveData(List<BookLocalModel> data) async {
    try {
      await DatabaseService.db.writeTxn(() async {
        await DatabaseService.db.bookLocalModels.putAll(data);
      });
    } catch (e) {
      logger.d(e);
    }
  }

  @override
  Future<void> updateData(BookLocalModel data) async {
    try {
      await DatabaseService.db.writeTxn(() async {
        await DatabaseService.db.bookLocalModels.put(data);
      });
    } catch (e) {
      logger.d(e);
    }
  }

  @override
  Future<List<BookLocalModel>> getUnsyncedData() async {
    return await DatabaseService.db.bookLocalModels
        .filter()
        .isSyncedEqualTo(false)
        .findAll();
  }

  Future<List<BookLocalModel>> getUpdatedDataForServerSync() async {
    return await DatabaseService.db.bookLocalModels
        .filter()
        .isSyncedEqualTo(true)
        .isUpdatedEqualTo(true)
        .findAll();
  }

  Future<void> clearServerOnlyData() async {
    await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.bookLocalModels
          .filter()
          .isFromServerEqualTo(true)
          .deleteAll();
    });
  }

  @override
  Future<void> clearSyncedData() async {
    try {
      await DatabaseService.db.writeTxn(() async {
        await DatabaseService.db.bookLocalModels
            .filter()
            .isSyncedEqualTo(true)
            .deleteAll();
      });
    } catch (e) {
      logger.d(e);
    }
  }

  @override
  Future<void> clearUnsyncedData() async {
    try {
      await DatabaseService.db.writeTxn(() async {
        await DatabaseService.db.bookLocalModels
            .filter()
            .isSyncedEqualTo(false)
            .deleteAll();
      });
    } catch (e) {
      logger.d(e);
    }
  }

  @override
  Future<List<BookLocalModel>> getsyncedData() async {
    return await DatabaseService.db.bookLocalModels
        .filter()
        .isSyncedEqualTo(true)
        .findAll();
  }

  @override
  Future<List<BookLocalModel>> getDataIsSyncFalseFirst() async {
    return await DatabaseService.db.bookLocalModels
        .where()
        .filter()
        .isSyncedEqualTo(false)
        .or()
        .isSyncedEqualTo(true)
        .sortByIsSynced()
        .findAll();
  }

  /// Ambil data untuk ditampilkan ke user
  /// Termasuk:
  /// - Data dari server (`isFromServer == true`)
  /// - Data update lokal (`isUpdated == true`)
  /// - Data yang belum disync (`isSynced == false`)
  Future<List<BookLocalModel>> getMergedDisplayData() async {
    return await DatabaseService.db.bookLocalModels
        .where()
        .filter()
        .isFromServerEqualTo(true)
        .or()
        .isUpdatedEqualTo(true)
        .or()
        .isSyncedEqualTo(false)
        .sortByIsSynced()
        .findAll();
  }
}

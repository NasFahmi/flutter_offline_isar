import 'package:isar/isar.dart';
import 'package:offline_mode/app/database/database_service.dart';
import 'package:offline_mode/app/database/queueService/model/sync_queue_model.dart';
import 'package:offline_mode/utils/logger/logger.dart';

import '../../../../utils/network_utils/network_utils.dart';
import '../../../../utils/shared_preferences_utils/shared_preferences_utils.dart';

class QueueService {
  // queue sync digunakan untuk operation post & put ketika creatae pasti pending
  Future<void> addQueue(
    String collectionName,
    String opreation,
    String payload,
    String link,
  ) async {
    final queue = SyncQueue()
      ..collectionName = collectionName
      ..operation = opreation
      ..payload = payload
      ..link = link
      ..status = Status.pending
      ..createdAt = DateTime.now();

    // Gunakan DatabaseService.db untuk mengakses instance Isar
    await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.syncQueues.put(queue);
    });
  }

  Future<void> syncQueue() async {
    final pendingQueue = await DatabaseService.db.syncQueues
        .filter()
        .statusEqualTo(Status.pending)
        .findAll();

    for (final queue in pendingQueue) {
      try {
        logger.d(queue);

        bool success = false;

        if (queue.operation == 'post') {
          success = await postToServer(queue);
        } else if (queue.operation == 'patch') {
          success = await patchToServer(queue);
        }

        await DatabaseService.db.writeTxn(() async {
          queue.status = success ? Status.success : Status.failed;
          await DatabaseService.db.syncQueues.put(queue);
        });
      } catch (e) {
        logger.e("Sync failed: $e");
        await DatabaseService.db.writeTxn(() async {
          queue.status = Status.failed;
          await DatabaseService.db.syncQueues.put(queue);
        });
      }
    }
  }

  Future<bool> postToServer(SyncQueue queue) async {
    final String? accessToken = await SharedPrefUtils().getAccessToken();
    final String body = queue.payload;
    final String link = queue.link;

    try {
      final response = await NetworkUtils(token: accessToken).post(link, body);
      logger.d(response.toString());

      final int statusCode = response[0] as int;
      if (statusCode != 201) {
        queue.errorMessage = response[1];
        await DatabaseService.db.writeTxn(() async {
          await DatabaseService.db.syncQueues.put(queue);
        });
        return false;
      }
      return true;
    } catch (e) {
      logger.e("Post failed: $e");
      return false;
    }
  }

  Future<bool> patchToServer(SyncQueue queue) async {
    final String? accessToken = await SharedPrefUtils().getAccessToken();
    final String body = queue.payload;
    final String link = queue.link;

    try {
      final response = await NetworkUtils(token: accessToken).patch(link, body);
      logger.d(response.toString());

      final int statusCode = response[0] as int;

      if (statusCode != 200) {
        queue.errorMessage = response[1];
        await DatabaseService.db.writeTxn(() async {
          await DatabaseService.db.syncQueues.put(queue);
        });
        return false;
      }
      return true;
    } catch (e) {
      logger.e("Patch failed: $e");
      return false;
    }
  }

  Future<void> clearQueue() async {
    await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.syncQueues.clear();
    });
  }

  Future<void> deleteQueue(int id) async {
    await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.syncQueues.delete(id);
    });
  }
}

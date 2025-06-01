import 'package:isar/isar.dart';
import 'package:offline_mode/app/database/database_service.dart';
import 'package:offline_mode/app/database/queueService/model/sync_queue_model.dart';
import 'package:offline_mode/utils/logger/logger.dart';

class QueueService {
  // queue sync digunakan untuk operation post & put
  Future<void> addQueue(
    String collectionName,
    String opreation,
    String payload,
    Status status,
  ) async {
    final queue = SyncQueue()
      ..collectionName = collectionName
      ..operation = opreation
      ..payload = payload
      ..status = status
      ..createdAt = DateTime.now();

    // Gunakan DatabaseService.db untuk mengakses instance Isar
    await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.syncQueues.put(queue);
    });
  }

  Future<void> syncNow() async {
    final pendingQueue = await DatabaseService.db.syncQueues
        .filter()
        .statusEqualTo(Status.pending) // atau cara filter status == "pending"
        .findAll();

    for (final queue in pendingQueue) {
      try {
        logger.d(queue);
        // Kirim ke server tergantung operation
        // final success = await _sendToServer(queue);

        // if (success) {
        //   // if success
        //   queue.status = Status.success;
        // } else {
        //   //if not
        //   queue.status = Status.failed;
        // }

        await DatabaseService.db.writeTxn(() async {
          await DatabaseService.db.syncQueues.put(queue);
        });
      } catch (e) {
        logger.d("Sync failed: $e");
      }
    }
  }
}

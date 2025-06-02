import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_mode/app/database/queueService/service/queue_service.dart';
import 'package:offline_mode/utils/logger/logger.dart';

import '../../../../database/queueService/model/sync_queue_model.dart';

part 'task_sync_event.dart';
part 'task_sync_state.dart';

class TaskSyncBloc extends Bloc<TaskSyncEvent, TaskSyncState> {
  TaskSyncBloc() : super(TaskSyncInitial()) {
    on<TaskSyncEvent>((event, emit) {});
    on<GetTaskSync>(getTaskSync);
  }
  Future<void> getTaskSync(GetTaskSync event,Emitter<TaskSyncState> emit) async {
    try {
      final data = await QueueService().getAllQueue();
      emit(TaskSyncSuccess(data: data));
    } catch (e) {
      logger.d(e);
    }
  }
}

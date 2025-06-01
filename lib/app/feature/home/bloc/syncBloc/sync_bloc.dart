import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_mode/app/database/queueService/service/queue_service.dart';

part 'sync_event.dart';
part 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  SyncBloc() : super(SyncInitial()) {
    on<SyncEvent>((event, emit) {});
    on<SyncQueueNow>(syncQueueNow);
  }
  Future<void> syncQueueNow(SyncQueueNow event, Emitter<SyncState> emit) async {
    emit(SyncLoading());
    try {
      await QueueService().syncQueue();
      emit(SyncSuccess());
    } catch (e) {
      emit(SyncFailed(e.toString()));
    }
  }
}

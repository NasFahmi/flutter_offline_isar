import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_sync_event.dart';
part 'task_sync_state.dart';

class TaskSyncBloc extends Bloc<TaskSyncEvent, TaskSyncState> {
  TaskSyncBloc() : super(TaskSyncInitial()) {
    on<TaskSyncEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

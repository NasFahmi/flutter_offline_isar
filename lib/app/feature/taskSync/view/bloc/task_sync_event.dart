part of 'task_sync_bloc.dart';

sealed class TaskSyncEvent extends Equatable {
  const TaskSyncEvent();

  @override
  List<Object> get props => [];
}
final class GetTaskSync extends TaskSyncEvent {}
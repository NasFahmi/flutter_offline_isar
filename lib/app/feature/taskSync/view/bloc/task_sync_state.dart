part of 'task_sync_bloc.dart';

sealed class TaskSyncState extends Equatable {
  const TaskSyncState();
  
  @override
  List<Object> get props => [];
}

final class TaskSyncInitial extends TaskSyncState {}
final class TaskSyncLoading extends TaskSyncState {}
final class TaskSyncSuccess extends TaskSyncState {
  final List<SyncQueue> data;

  const TaskSyncSuccess({required this.data});
}
final class TaskSyncFailed extends TaskSyncState {
  final String message;

  const TaskSyncFailed({required this.message});
}

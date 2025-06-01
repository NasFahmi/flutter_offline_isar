part of 'task_sync_bloc.dart';

sealed class TaskSyncState extends Equatable {
  const TaskSyncState();
  
  @override
  List<Object> get props => [];
}

final class TaskSyncInitial extends TaskSyncState {}

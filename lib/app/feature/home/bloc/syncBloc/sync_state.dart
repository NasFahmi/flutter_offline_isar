part of 'sync_bloc.dart';

sealed class SyncState extends Equatable {
  const SyncState();
  
  @override
  List<Object> get props => [];
}

final class SyncInitial extends SyncState {}
final class SyncLoading extends SyncState {}
final class SyncFailed extends SyncState {
  final String message;
  const SyncFailed(this.message);
}
final class SyncSuccess extends SyncState {}
final class TokenExpiredState extends SyncState {}
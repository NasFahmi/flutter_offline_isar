part of 'delete_book_bloc.dart';

sealed class DeleteBookState extends Equatable {
  const DeleteBookState();
  
  @override
  List<Object> get props => [];
}

final class DeleteBookInitial extends DeleteBookState {}
final class DeleteBookLoading extends DeleteBookState {}
final class DeleteBookProcess extends DeleteBookState {}
final class DeleteBookSuccess extends DeleteBookState {}
final class DeleteBookFailed extends DeleteBookState {
  final String error;

  const DeleteBookFailed({required this.error});
}
final class TokenExpiredState extends DeleteBookState {}
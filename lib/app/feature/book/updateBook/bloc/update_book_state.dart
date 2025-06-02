part of 'update_book_bloc.dart';

sealed class UpdateBookState extends Equatable {
  const UpdateBookState();
  
  @override
  List<Object> get props => [];
}
final class UpdateBookLoadLoading extends UpdateBookState {}
final class UpdateBookLoadSuccess extends UpdateBookState {
  final BookLocalModel data;
  const UpdateBookLoadSuccess(this.data);
}
final class UpdateBookLoadFailed extends UpdateBookState {
  final String message;
  const UpdateBookLoadFailed(this.message);
}


final class UpdateBookInitial extends UpdateBookState {}
final class UpdateBookLoading extends UpdateBookState {}
final class UpdateBookProcess extends UpdateBookState {}
final class UpdateBookFailed extends UpdateBookState {
  final String message;
  const UpdateBookFailed(this.message);
}
final class UpdateBookSuccess extends UpdateBookState {}
final class TokenExpiredState extends UpdateBookState {}
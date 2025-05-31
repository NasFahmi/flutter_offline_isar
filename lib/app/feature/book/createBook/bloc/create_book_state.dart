part of 'create_book_bloc.dart';

sealed class CreateBookState extends Equatable {
  const CreateBookState();
  
  @override
  List<Object> get props => [];
}

final class CreateBookInitial extends CreateBookState {}
final class CreateBookLoading extends CreateBookState {}
final class CreateBookProcess extends CreateBookState {}
final class CreateBookFailed extends CreateBookState {
  final String message;
  const CreateBookFailed(this.message);
}
final class CreateBookSuccess extends CreateBookState {}
final class TokenExpiredState extends CreateBookState {}
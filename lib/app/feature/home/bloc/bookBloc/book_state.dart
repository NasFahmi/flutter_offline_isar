part of 'book_bloc.dart';

sealed class BookState extends Equatable {
  const BookState();
  
  @override
  List<Object> get props => [];
}

final class BookInitial extends BookState {}
final class BookLoading extends BookState {}
final class BookSuccess extends BookState {
  final GetListBookModel books;
  const BookSuccess({required this.books});
}
final class BookFailed extends BookState {
  final String message;

  const BookFailed({required this.message});
}

final class BookLocalSuccess extends BookState {
  final List<BookLocalModel> books;
  const BookLocalSuccess(this.books);
}

final class TokenExpiredState extends BookState{}
part of 'detail_book_bloc.dart';

sealed class DetailBookState extends Equatable {
  const DetailBookState();
  
  @override
  List<Object> get props => [];
}

final class DetailBookInitial extends DetailBookState {}
final class DetailBookLoading extends DetailBookState {}
final class DetailBookSuccess extends DetailBookState{
  final GetBookByIdModel book; //model from server
  const DetailBookSuccess(this.book);
  @override
  List<Object> get props => [book];
}
final class DetailBookLocalSuccess extends DetailBookState{
  final BookLocalModel book; //model from server
  const DetailBookLocalSuccess(this.book);
  @override
  List<Object> get props => [book];
}
final class DetailBookFailed extends DetailBookState{
  final String message;
  const DetailBookFailed(this.message);
  @override
  List<Object> get props => [message];
}
final class TokenExpiredState extends DetailBookState {}
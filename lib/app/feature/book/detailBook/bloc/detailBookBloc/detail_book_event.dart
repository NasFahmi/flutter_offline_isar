part of 'detail_book_bloc.dart';

sealed class DetailBookEvent extends Equatable {
  const DetailBookEvent();

  @override
  List<Object> get props => [];
}
class GetDetailBookById extends DetailBookEvent{
  final String id;
  const GetDetailBookById(this.id);
}
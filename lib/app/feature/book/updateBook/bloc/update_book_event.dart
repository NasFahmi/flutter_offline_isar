part of 'update_book_bloc.dart';

sealed class UpdateBookEvent extends Equatable {
  const UpdateBookEvent();

  @override
  List<Object> get props => [];
}
final class UpdateBookSubmited extends UpdateBookEvent{
  final String id;
  final String title;
  final String author;
  final String decs;
  final String publishedAt;

  const UpdateBookSubmited({
    required this.id,
    required this.title,
    required this.author,
    required this.decs,
    required this.publishedAt,
  });
}
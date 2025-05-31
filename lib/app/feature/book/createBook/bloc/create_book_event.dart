part of 'create_book_bloc.dart';

sealed class CreateBookEvent extends Equatable {
  const CreateBookEvent();

  @override
  List<Object> get props => [];
}

final class CreateBookSubmited extends CreateBookEvent{
  final String title;
  final String author;
  final String decs;
  final String publishedAt;

  const CreateBookSubmited({
    required this.title,
    required this.author,
    required this.decs,
    required this.publishedAt,
  });
}
part of 'delete_book_bloc.dart';

sealed class DeleteBookEvent extends Equatable {
  const DeleteBookEvent();

  @override
  List<Object> get props => [];
}
final class DeleteBookById extends DeleteBookEvent {
  final String id;

  const DeleteBookById({required this.id});
}
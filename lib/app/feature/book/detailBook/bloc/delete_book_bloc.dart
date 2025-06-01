import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_mode/utils/shared_preferences_utils/shared_preferences_utils.dart';

import '../service/book_services.dart';

part 'delete_book_event.dart';
part 'delete_book_state.dart';

class DeleteBookBloc extends Bloc<DeleteBookEvent, DeleteBookState> {
  DeleteBookBloc() : super(DeleteBookInitial()) {
    on<DeleteBookEvent>((event, emit) {});
    on<DeleteBookById>(deleteBook);
  }
  Future<void> deleteBook(
    DeleteBookById event,
    Emitter<DeleteBookState> emit,
  ) async {
    emit(DeleteBookProcess());
    emit(DeleteBookLoading());
    String? accessToken = await SharedPrefUtils().getAccessToken();
    if (accessToken == null) {
      emit(TokenExpiredState());
    } else {
      try {
        dynamic response = await BookServices().deleteBook(
          accessToken,event.id,
        );
        int statusCode = response[0] as int;
        if (statusCode == 200) {
          emit(DeleteBookSuccess());
        } else if (statusCode == 401) {
          emit(TokenExpiredState());
        } else {
          emit(DeleteBookFailed(error: response[1].toString()));
        }
      } catch (error) {
        emit(DeleteBookFailed(error: error.toString()));
      }
    }
  }
}

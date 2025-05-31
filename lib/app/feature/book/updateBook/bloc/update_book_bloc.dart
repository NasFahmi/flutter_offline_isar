import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_mode/app/feature/book/createBook/model/book_post_model.dart';
import 'package:offline_mode/utils/shared_preferences_utils/shared_preferences_utils.dart';

import '../service/book_services.dart';

part 'update_book_event.dart';
part 'update_book_state.dart';

class UpdateBookBloc extends Bloc<UpdateBookEvent, UpdateBookState> {
  UpdateBookBloc() : super(UpdateBookInitial()) {
    on<UpdateBookEvent>((event, emit) {});
    on<UpdateBookSubmited>(updateBook);
  }
  Future<void> updateBook(
    UpdateBookSubmited event,
    Emitter<UpdateBookState> emit,
  ) async {
    emit(UpdateBookProcess());
    emit(UpdateBookLoading());
    String? accessToken = await SharedPrefUtils().getAccessToken();
    if (accessToken == null) {
      emit(TokenExpiredState());
    } else {
      try {
        BookPostModel data = BookPostModel(
          title: event.title,
          author: event.author,
          description: event.decs,
          publishedAt: event.publishedAt,
        );
        dynamic response = await BookServices().updateBook(data, accessToken,event.id);
        int statusCode = response[0] as int;
        if (statusCode == 201) {
          emit(UpdateBookSuccess());
        } else if (statusCode == 401) {
          emit(TokenExpiredState());
        } else {
          emit(UpdateBookFailed(response[1].toString()));
        }
      } catch (error) {
        emit(UpdateBookFailed(error.toString()));
      }
    }
  }
}

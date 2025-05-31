import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_mode/app/feature/book/createBook/model/book_post_model.dart';
import '../service/book_services.dart';
import 'package:offline_mode/utils/shared_preferences_utils/shared_preferences_utils.dart';

part 'create_book_event.dart';
part 'create_book_state.dart';

class CreateBookBloc extends Bloc<CreateBookEvent, CreateBookState> {
  CreateBookBloc() : super(CreateBookInitial()) {
    on<CreateBookEvent>((event, emit) {});
    on<CreateBookSubmited>(createBook);
  }
  Future<void> createBook(
    CreateBookSubmited event,
    Emitter<CreateBookState> emit,
  ) async {
    emit(CreateBookProcess());
    emit(CreateBookLoading());
    String? accessToken = await SharedPrefUtils().getAccessToken();
    if (accessToken == null) {
      emit(TokenExpiredState());
    } else {
      try {
        BookPostModel data = BookPostModel(title: event.title, author: event.author, description: event.decs, publishedAt: event.publishedAt);
        dynamic response = await BookServices().createBook(
          data,
          accessToken,
        );
        int statusCode = response[0] as int;
        if (statusCode == 201) {
          emit(CreateBookSuccess());
        } else if (statusCode == 401) {
          emit(TokenExpiredState());
        } else {
          emit(CreateBookFailed(response[1].toString()));
        }
      } catch (error) {
        emit(CreateBookFailed(error.toString()));
      }
    }
  }
}

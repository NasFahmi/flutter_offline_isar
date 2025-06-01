import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_mode/app/feature/book/createBook/model/book_post_model.dart';
import '../../../../../utils/api_utils/api_utils.dart';
import '../../../../database/queueService/service/queue_service.dart';
import '../../models/book_model.dart';
import '../../services/book_db_service.dart';
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
        // try for create data offline first
        final book = BookLocalModel()
          ..serverId = null
          ..title = event.title
          ..author = event.author
          ..description = event.decs
          ..publishedAt = event.publishedAt
          ..createdAt = DateTime.now()
          ..updatedAt = DateTime.now()
          ..isSynced = false;
        // buat local data offline terlebih dahulu
        await BookDbService().createData(book);
        // buat queue untuk SyncQueue terlebih dahulu
        BookPostModel data = BookPostModel(
          title: event.title,
          author: event.author,
          description: event.decs,
          publishedAt: event.publishedAt,
        );
        String payload = json.encode(data.toJson());
        final String link = ApiUtils().urlCreateBook();
        await QueueService().addQueue('book', 'post', payload, link);

        emit(CreateBookSuccess());
        // BookPostModel data = BookPostModel(title: event.title, author: event.author, description: event.decs, publishedAt: event.publishedAt);
        // dynamic response = await BookServices().createBook(
        //   data,
        //   accessToken,
        // );
        // int statusCode = response[0] as int;
        // if (statusCode == 201) {
        //   emit(CreateBookSuccess());
        // } else if (statusCode == 401) {
        //   emit(TokenExpiredState());
        // } else {
        //   emit(CreateBookFailed(response[1].toString()));
        // }
      } catch (error) {
        emit(CreateBookFailed(error.toString()));
      }
    }
  }
}

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_mode/app/feature/book/createBook/model/book_post_model.dart';
import 'package:offline_mode/utils/api_utils/api_utils.dart';
import 'package:offline_mode/utils/shared_preferences_utils/shared_preferences_utils.dart';

import '../../../../database/queueService/service/queue_service.dart';
import '../../models/book_model.dart';
import '../../services/book_db_service.dart';
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
    emit(UpdateBookLoading());
    emit(UpdateBookProcess());
    String? accessToken = await SharedPrefUtils().getAccessToken();
    if (accessToken == null) {
      emit(TokenExpiredState());
    } else {
      try {
        BookLocalModel? data = await BookDbService().getDataById(event.id);  
        data?.title = event.title;
        data?.author = event.author;
        data?.description = event.decs;
        data?.publishedAt = event.publishedAt;
        data?.updatedAt = DateTime.now();

        await BookDbService().updateData(data!);  

        // buat queue untuk SyncQueue 
        BookPostModel dataPatch = BookPostModel(
          title: event.title,
          author: event.author,
          description: event.decs,
          publishedAt: event.publishedAt,
        );
        String payload = json.encode(dataPatch.toJson());
        final String link = ApiUtils().urlUpdateBook(event.id);
        await QueueService().addQueue('book', 'patch', payload, link);

        emit(UpdateBookSuccess());
        // BookPostModel data = BookPostModel(
        //   title: event.title,
        //   author: event.author,
        //   description: event.decs,
        //   publishedAt: event.publishedAt,
        // );
        // dynamic response = await BookServices().updateBook(data, accessToken,event.id);
        // int statusCode = response[0] as int;
        // if (statusCode == 201) {
        //   emit(UpdateBookSuccess());
        // } else if (statusCode == 401) {
        //   emit(TokenExpiredState());
        // } else {
        //   emit(UpdateBookFailed(response[1].toString()));
        // }
      } catch (error) {
        emit(UpdateBookFailed(error.toString()));
      }
    }
  }
}

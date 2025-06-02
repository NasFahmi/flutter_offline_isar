import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_mode/app/feature/book/createBook/model/book_post_model.dart';
import 'package:offline_mode/utils/api_utils/api_utils.dart';
import 'package:offline_mode/utils/shared_preferences_utils/shared_preferences_utils.dart';

import '../../../../database/queueService/service/queue_service.dart';
import '../../detailBook/model/get_book_by_id_model.dart';
import '../../models/book_model.dart';
import '../../services/book_db_service.dart';
import '../service/book_services.dart';

part 'update_book_event.dart';
part 'update_book_state.dart';

class UpdateBookBloc extends Bloc<UpdateBookEvent, UpdateBookState> {
  UpdateBookBloc() : super(UpdateBookInitial()) {
    on<UpdateBookEvent>((event, emit) {});
    on<UpdateBookSubmited>(updateBook);
    on<GetDetailBookforUpdate>(getDetailBookforUpdate);
  }
  Future<void> getDetailBookforUpdate(
    GetDetailBookforUpdate event,
    Emitter<UpdateBookState> emit,
  ) async {
    emit(UpdateBookLoadLoading());
    String? accessToken = await SharedPrefUtils().getAccessToken();
    // get first from local
    final localBooks = await BookDbService().getDataById(event.serverId);
    if (localBooks != null) {
      emit(UpdateBookLoadSuccess(localBooks));
    } else {
      // get from server
      dynamic response = await BookServices().getBookById(
        accessToken!,
        event.serverId,
      );
      int statusCode = response[0] as int;
      GetBookByIdModel book = GetBookByIdModel.fromJson(response[1]);
      if (statusCode == 200) {
        BookLocalModel localBook = BookLocalModel.fromServerData(book.data);
        emit(UpdateBookLoadSuccess(localBook));
        // !konversi data dari server ke lokal
        // store to local db
        await BookDbService().createData(localBook);
        emit(UpdateBookLoadSuccess(localBook));
      }
    }
    try {} catch (e) {
      emit(UpdateBookLoadFailed(e.toString()));
    }
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
        // jika isSync == false, maka kita hanya perlu ubah data di local tanpa membuat data untuk sync queue
        BookLocalModel? data = await BookDbService().getDataById(event.id); //get data by server id
        if (event.isSync) {
          //!ini khusus update data server dari lokal
          data?.title = event.title;
          data?.author = event.author;
          data?.description = event.decs;
          data?.publishedAt = event.publishedAt;
          data?.isUpdated = true; // untuk menandai bahwa data sudah di update
          data?.isSynced = false;
          data?.isFromServer = true;
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
        } else {
          data?.title = event.title;
          data?.author = event.author;
          data?.description = event.decs;
          data?.publishedAt = event.publishedAt;
          data?.isUpdated = true; // untuk menandai bahwa data sudah di update
          data?.isSynced = false;
          data?.isFromServer = false;
          data?.updatedAt = DateTime.now();

          await BookDbService().updateData(data!);
          emit(UpdateBookSuccess());
        }
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

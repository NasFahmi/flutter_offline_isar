import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_mode/app/feature/home/model/get_list_book_model.dart';
import 'package:offline_mode/app/feature/home/service/book_services.dart';
import 'package:offline_mode/utils/logger/logger.dart';
import 'package:offline_mode/utils/shared_preferences_utils/shared_preferences_utils.dart';

import '../../../book/models/book_model.dart';
import '../../../book/services/book_db_service.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial()) {
    on<BookEvent>((event, emit) {});
    on<GetBookEvent>(getBookEvent);
  }
  Future<void> getBookEvent(GetBookEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    String? accessToken = await SharedPrefUtils().getAccessToken();

    if (accessToken == null) {
      emit(TokenExpiredState());
    } else {
      try {
        // ✅ Ambil dari lokal dulu
        final localBooks = await BookDbService().getAllData();
        if (localBooks.isNotEmpty) {
          emit(BookLocalSuccess(localBooks));
        }

        dynamic response = await BookServices().getListBook(accessToken);
        int statusCode = response[0] as int;
        GetListBookModel book = GetListBookModel.fromJson(response[1]);
        // logger.d(jadwalPosyandu.data[0].namaKegiatan);
        if (statusCode == 200) {
          logger.d('succes get data book');
          logger.d(book);

          // !konversi data dari server ke lokal
          List<BookModel> localBooks = book.data
              .map((b) => BookModel.fromServer(b)) // Buat converter-nya
              .toList();

          // 💾 Simpan ke lokal (replace)
          await BookDbService().clearData();
          await BookDbService().saveData(localBooks);

          // ✅ Ambil dari lokal lagi untuk pastikan konsistensi
          final updatedLocal = await BookDbService().getAllData();
          emit(BookLocalSuccess(updatedLocal));
          // emit(BookSuccess(books: book));
        } else if (statusCode == 401) {
          emit(TokenExpiredState());
        } else {
          emit(BookFailed(message: book.message));
        }
      } catch (error) {
        emit(BookFailed(message: error.toString()));
      }
    }
  }
}

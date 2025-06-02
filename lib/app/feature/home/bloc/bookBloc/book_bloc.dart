import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
        final bool isConnected =
            await InternetConnectionChecker.instance.hasConnection;
        logger.d('is connected $isConnected in home');
        // ✅ Ambil dari lokal dulu
        final localBooks = await BookDbService().getDataIsSyncFalseFirst();
        if (localBooks.isNotEmpty) {
          emit(BookLocalSuccess(localBooks));
        }
        if (isConnected) {
          dynamic response = await BookServices().getListBook(accessToken);
          int statusCode = response[0] as int;
          GetListBookModel book = GetListBookModel.fromJson(response[1]);
          // logger.d(jadwalPosyandu.data[0].namaKegiatan);
          if (statusCode == 200) {
            emit(BookSuccess(books: book));
            logger.d('succes get data book');
            logger.d(book);

            // !konversi data dari server ke lokal
            List<BookLocalModel> localBooks = book.data
                .map(
                  (b) => BookLocalModel.fromServerDatum(b),
                ) // Buat converter-nya
                .toList();

            // 💾 Simpan ke lokal (replace)
            await BookDbService()
                .clearSyncedData(); // hanya hapus yang dari server
            final unsyncedLocalBooks = await BookDbService().getUnsyncedData();

            // ✅ Ambil dari lokal lagi untuk pastikan konsistensi
            await BookDbService().saveData(unsyncedLocalBooks);
            await BookDbService().saveData(
              localBooks,
            ); //save hasil fecth ke db lokal
            final updatedLocal = await BookDbService().getAllData();
            emit(BookLocalSuccess(updatedLocal));
            // emit(BookSuccess(books: book));
          } else if (statusCode == 401) {
            emit(TokenExpiredState());
          } else {
            emit(BookFailed(message: book.message));
          }
        } else {
          emit(BookFailed(message: 'Tidak ada koneksi internet'));
        }
      } catch (error) {
        emit(BookFailed(message: error.toString()));
      }
    }
  }
}

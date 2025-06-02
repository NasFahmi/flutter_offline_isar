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

    final accessToken = await SharedPrefUtils().getAccessToken();
    if (accessToken == null) {
      emit(TokenExpiredState());
      return;
    }

    try {
      final bool isConnected =
          await InternetConnectionChecker.instance.hasConnection;
      logger.d('is connected $isConnected in home');

      // ✅ Ambil semua data lokal (data dari server, dan data hasil create/update lokal)
      final localBooks = await BookDbService().getMergedDisplayData();
      emit(BookLocalSuccess(localBooks));

      if (isConnected) {
        // ✅ Fetch dari server
        final response = await BookServices().getListBook(accessToken);
        final statusCode = response[0] as int;
        final serverData = GetListBookModel.fromJson(response[1]);

        if (statusCode == 200) {
          logger.d('Success get data book from server');
          logger.d(serverData);

          // ✅ Konversi dan tandai data hasil dari server
          final fetchedServerBooks = serverData.data
              .map(
                (b) => BookLocalModel.fromServerDatum(b)..isFromServer = true,
              )
              .toList();

          // ✅ Hapus hanya data hasil fetch server sebelumnya
          await BookDbService().clearServerOnlyData();

          // ✅ Ambil ulang data lokal yang:
          // - Belum tersinkronisasi
          // - Merupakan update lokal terhadap data server
          final unsynced = await BookDbService().getUnsyncedData();
          final updatedFromServer = await BookDbService()
              .getUpdatedDataForServerSync();

          // ✅ Simpan kembali data agar merge sempurna
          await BookDbService().saveData(unsynced);
          await BookDbService().saveData(updatedFromServer);
          await BookDbService().saveData(fetchedServerBooks);

          // ✅ Ambil ulang semua data untuk ditampilkan
          final mergedBooks = await BookDbService().getMergedDisplayData();
          emit(BookLocalSuccess(mergedBooks));
        } else if (statusCode == 401) {
          emit(TokenExpiredState());
        } else {
          emit(BookFailed(message: serverData.message));
        }
      }
    } catch (e) {
      emit(BookFailed(message: e.toString()));
    }
  }
}

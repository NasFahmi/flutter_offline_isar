import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_mode/app/feature/book/detailBook/model/get_book_by_id_model.dart';
import 'package:offline_mode/app/feature/home/model/get_list_book_model.dart' as get_list_book;

import '../../../../../../utils/shared_preferences_utils/shared_preferences_utils.dart';
import '../../../models/book_model.dart';
import '../../../services/book_db_service.dart';
import '../../service/book_services.dart';

part 'detail_book_event.dart';
part 'detail_book_state.dart';

class DetailBookBloc extends Bloc<DetailBookEvent, DetailBookState> {
  DetailBookBloc() : super(DetailBookInitial()) {
    on<DetailBookEvent>((event, emit) {});
    on<GetDetailBookById>(getDetailById);
  }
  Future<void> getDetailById(
    GetDetailBookById event,
    Emitter<DetailBookState> emit,
  ) async {
    emit(DetailBookLoading());
    String? accessToken = await SharedPrefUtils().getAccessToken();
    try {
      if (accessToken == null) {
        emit(TokenExpiredState());
      } else {
        // get first from local
        final localBooks = await BookDbService().getDataById(event.id);
        if (localBooks != null) {
          emit(DetailBookLocalSuccess(localBooks));
        } else {
          // get from server
          dynamic response = await BookServices().getBookById(
            accessToken,
            event.id,
          );
          int statusCode = response[0] as int;
          GetBookByIdModel book = GetBookByIdModel.fromJson(response[1]);
          if (statusCode == 200) {
            emit(DetailBookSuccess(book));
            // !konversi data dari server ke lokal
            // / Konversi data dari server ke lokal
            BookLocalModel localBook = BookLocalModel.fromServerData(book.data);
            // store to local db
            await BookDbService().createData(localBook);
            emit(DetailBookLocalSuccess(localBook));
          }
        }
      }
    } catch (error) {
      emit(DetailBookFailed(error.toString()));
    }
  }
}

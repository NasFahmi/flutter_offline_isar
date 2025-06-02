import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_mode/app/feature/login/model/get_user_detial_model.dart';
import 'package:offline_mode/app/feature/login/model/login_post_model.dart';
import 'package:offline_mode/app/feature/login/model/login_response_model.dart';
import 'package:offline_mode/app/feature/login/service/login_services.dart';
import 'package:offline_mode/utils/logger/logger.dart';
import 'package:offline_mode/utils/shared_preferences_utils/shared_preferences_utils.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginSubmited>(login);
  }

  Future<void> login(LoginSubmited event, Emitter<LoginState> emit) async {
    emit(LoginProcess());
    emit(LoginLoading());

    try {
      logger.d("email ${event.email} password ${event.password}");
      LoginPostModel data = LoginPostModel(
        username: event.email,
        password: event.password,
      );
      List<dynamic> response = await LoginServices().loginService(data);

      int statusCode = response[0] as int;
      logger.d('status code = ${statusCode.toString()}');
      LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        response[1],
      );
      logger.d(loginResponseModel.toString());

      if (statusCode == 200) {
        List<dynamic> responseMe = await LoginServices().me(
          loginResponseModel.accessToken,
        );
        GetDetailUserModel responseMeModel = GetDetailUserModel.fromJson(
          responseMe[1],
        );
        SharedPrefUtils().storedAccessToken(loginResponseModel.accessToken);
        SharedPrefUtils().storedRefreshToken(loginResponseModel.refreshToken);
        SharedPrefUtils().storedAccount(responseMeModel.id);
        emit(LoginSuccess());
      } else if (statusCode == 400) {
        emit(LoginFailed("error Validation"));
      } else {
        emit(LoginFailed("error Server"));
      }
    } catch (error) {
      logger.d(error.toString());
      emit(LoginFailed(error.toString()));
    }
  }
}

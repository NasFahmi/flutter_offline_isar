import 'dart:convert';

import 'package:offline_mode/app/feature/login/model/login_post_model.dart';
import 'package:offline_mode/utils/api_utils/api_utils.dart';
import 'package:offline_mode/utils/logger/logger.dart';
import 'package:offline_mode/utils/network_utils/network_utils.dart';

class LoginServices {
  Future<List<dynamic>> loginService(LoginPostModel loginModel) async {
    logger.d('api service');
    final String link = ApiUtils().urlLogin();
    final String body = json.encode(loginModel.toJson());

    return await NetworkUtils().post(link, body).then((response) {
      logger.d(response.toString());
      return response;
    });
  }
}

import 'dart:convert';

import 'package:offline_mode/utils/api_utils/api_utils.dart';
import 'package:offline_mode/utils/network_utils/network_utils.dart';

class LogoutServices {
  Future<List<dynamic>> logoutService(String token) async {
    final String link = ApiUtils().urlLogout();
    final String body = json.encode({});

    return await NetworkUtils(token: token).post(link, body).then((response) {
      return response;
    });
  }
}

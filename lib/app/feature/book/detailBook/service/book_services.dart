import 'dart:convert';

import 'package:offline_mode/utils/api_utils/api_utils.dart';
import 'package:offline_mode/utils/logger/logger.dart';
import 'package:offline_mode/utils/network_utils/network_utils.dart';

class BookServices {
  Future<List<dynamic>> deleteBook(String token, String id ) async {
    final String link = ApiUtils().urlDeleteBook(id);
    final String body = json.encode({});

    return await NetworkUtils(token: token).delete(link, body).then((response) {
      logger.d(response.toString());
      return response;
    });
  }
  Future<List<dynamic>> getBookById(String token,String id) async {
    final String link = ApiUtils().urlGetBookById(id);
    final Map<String, dynamic> parameterQuery = {};

    return await NetworkUtils(token: token).get(link, parameterQuery).then((
      response,
    ) {
      logger.d(response.toString());
      return response;
    });
  }
}
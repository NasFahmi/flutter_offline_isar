import 'dart:convert';

import 'package:offline_mode/app/feature/book/createBook/model/book_post_model.dart';
import 'package:offline_mode/utils/api_utils/api_utils.dart';
import 'package:offline_mode/utils/logger/logger.dart';
import 'package:offline_mode/utils/network_utils/network_utils.dart';

class BookServices {
  Future<dynamic> createBook(
    BookPostModel postJadwalPosyanduModel,
    String accessToken,
  ) async {
    final String link = ApiUtils().urlCreateBook();
    final String body = json.encode(postJadwalPosyanduModel.toJson());

    return await NetworkUtils(token: accessToken).post(link, body).then((
      response,
    ) {
      logger.d(response.toString());
      return response;
    });
  }
}

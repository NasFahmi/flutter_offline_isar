import 'package:offline_mode/utils/api_utils/api_utils.dart';
import 'package:offline_mode/utils/logger/logger.dart';
import 'package:offline_mode/utils/network_utils/network_utils.dart';

class BookServices {
  Future<List<dynamic>> getListBook (String token) async {
    final String link = ApiUtils().urlBook();
    final Map<String, dynamic> parameterQuery = {
      'limit': 5000
    };

    return await NetworkUtils(token: token).get(link, parameterQuery).then((response) {
      logger.d(response.toString());
      return response;
    });
  }
}
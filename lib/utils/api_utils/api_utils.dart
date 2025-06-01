part 'api_name.dart';

class ApiUtils {
  //!Base URL
  final String _baseUrl = "http://10.0.2.2:3000";
  // final String _baseUrlQuaryParameter = "now4kswkgo4owoks884o0wc0.103.109.210.102.sslip.io";
  final String _apiVersion = "/api/v1";

  //!Header
  // Map<String, String> header() =>
  //     {'Content-Type': 'application/json', 'Accept': 'application/json'};

  Map<String, String> headerWithToken(String token) => {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Map<String, String> headerTokenForMultipart(String token) => {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'multipart/form-data',
  //     };

  //!Auth
  String urlLogin() {
    String urlLogin = LinkApi.LOGINURL;
    return _baseUrl + _apiVersion + urlLogin;
  }

  String urlRefreshToken() {
    String urlRefreshToken = LinkApi.REFRESHTOKENURL;
    return _baseUrl + _apiVersion + urlRefreshToken;
  }

  String urlLogout() {
    String urlLogout = LinkApi.LOGOUTURL;
    return _baseUrl + _apiVersion + urlLogout;
  }

  String urlBook() {
    String urlBook = LinkApi.BOOKURL;
    return _baseUrl + _apiVersion + urlBook;
  }

  String urlCreateBook() {
    String urlBook = LinkApi.BOOKURL;
    return _baseUrl + _apiVersion + urlBook;
  }

  String urlUpdateBook(String id) {
    String urlBook = LinkApi.BOOKURL;
    return '$_baseUrl$_apiVersion$urlBook/$id';
  }

  String urlDeleteBook(String id) {
    String urlBook = LinkApi.BOOKURL;
    return '$_baseUrl$_apiVersion$urlBook/$id';
  }
}

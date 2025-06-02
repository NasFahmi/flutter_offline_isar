// ignore_for_file: constant_identifier_names

part of 'api_utils.dart';

abstract class LinkApi {
  LinkApi._();

  //!Auth
  static const LOGINURL = "/auth/login";
  static const REFRESHTOKENURL = "/auth/refresh-token";
  static const LOGOUTURL = "/auth/logout";
  static const REGISTERURL = "/auth/register";
  static const BOOKURL = "/books";
  static const USERURL = "/users/me";
}

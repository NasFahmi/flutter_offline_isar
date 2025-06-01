import 'package:flutter/material.dart';
import 'package:offline_mode/app/feature/book/createBook/view/create_book.dart';
import 'package:offline_mode/app/feature/book/detailBook/view/detail_book.dart';
import 'package:offline_mode/app/feature/taskSync/view/task_sync.dart';
import 'package:offline_mode/app/feature/home/model/get_list_book_model.dart'
    as book;
import 'package:offline_mode/app/feature/home/view/home.dart';
import 'package:offline_mode/app/feature/login/view/login.dart';
import 'package:offline_mode/app/feature/register/view/register.dart';
import 'package:offline_mode/app/feature/book/updateBook/view/update_book.dart';
import 'package:page_transition/page_transition.dart';
import '../app/feature/splash_screen/view/splash_screen.dart';
import '../app/view/page_not_found_screen.dart';
import './route_name.dart';

class MyRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASHSCREEN:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
      // ? Login
      case LOGIN:
        return MaterialPageRoute(
          builder: (context) => const Login(),
          settings: settings,
        );
      // ? Register
      case REGISTER:
        return MaterialPageRoute(
          builder: (context) => const Register(),
          settings: settings,
        );
      // ?Home
      case HOME:
        return MaterialPageRoute(
          builder: (context) => const Home(),
          settings: settings,
        );

      //? Detail Book
      case DETAILBOOK:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => DetailBook(id: args),
          settings: settings,
        );

      //?create book
      case CREATEBOOK:
        return MaterialPageRoute(
          builder: (context) => const CreateBook(),
          settings: settings,
        );

      //? update book
      case UPDATEBOOK:
        final args = settings.arguments as book.Datum;
        return MaterialPageRoute(
          builder: (context) => UpdateBook(data: args),
          settings: settings,
        );

        //? TaskSync
      case TASKSYNC:
        return MaterialPageRoute(
          builder: (context) => TaskSync(),
          settings: settings,
        );

      default:
        return PageTransition(
          child: const PageNotFoundScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 600),
          settings: settings,
        );
    }
  }
}

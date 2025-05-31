
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_mode/app/feature/authorization/bloc/blocAuthentication/authentication_bloc.dart';
import 'package:offline_mode/app/feature/authorization/bloc/blocAuthorization/authorization_bloc.dart';
import 'package:offline_mode/config/screen_config/size_config.dart';
import 'package:offline_mode/config/theme/theme.dart';
import 'package:offline_mode/route/route_name.dart';
import 'package:offline_mode/route/route_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AuthorizationBloc()),
      BlocProvider(create: (context) => AuthenticationBloc()),
    ], child: const BuildApp());
  }
}

class BuildApp extends StatelessWidget {
  const BuildApp({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    String? screen;
    SizeConfig.init(context);
    return MaterialApp(
      locale: const Locale('id', 'ID'), // Set default ke Indonesia
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('id', 'ID'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Puspadaya',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      onGenerateRoute: MyRoute.generateRoute,
      initialRoute: SPLASHSCREEN,
      // home: const AnakListScreen(),
    );
  }
}

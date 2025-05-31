import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_mode/app/feature/authorization/bloc/blocAuthentication/authentication_bloc.dart';
import 'package:offline_mode/app/feature/authorization/bloc/blocAuthorization/authorization_bloc.dart';
import 'package:offline_mode/route/route_name.dart';
import 'package:offline_mode/utils/logger/logger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // FlutterNativeSplash.remove();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      BlocProvider.of<AuthenticationBloc>(context).add(AppStartEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        logger.d(state.toString());
        if (state is AuthenticationFirstTime) {
          BlocProvider.of<AuthorizationBloc>(
            context,
          ).add(AuthorizationFalseEvent());
          Navigator.pushReplacementNamed(context, LOGIN);
        }
        if (state is AuthenticationTrue) {
          BlocProvider.of<AuthorizationBloc>(
            context,
          ).add(AuthorizationTrueEvent());
          Navigator.pushReplacementNamed(context, HOME);
        }
        if (state is AuthenticationFalse) {
          BlocProvider.of<AuthorizationBloc>(
            context,
          ).add(AuthorizationFalseEvent());
          Navigator.pushReplacementNamed(context, LOGIN);
        }
      },
      child: Scaffold(
        body: SafeArea(child: Center(child: Text("Splash Screen"))),
      ),
    );
  }
}

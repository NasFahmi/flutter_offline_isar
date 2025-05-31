import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_mode/app/feature/authorization/bloc/blocAuthorization/authorization_bloc.dart';
import 'package:offline_mode/app/feature/login/bloc/login_bloc.dart';
import 'package:offline_mode/route/route_name.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authorizationBloc = BlocProvider.of<AuthorizationBloc>(context);
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          authorizationBloc.add(AuthorizationTrueEvent());
          Navigator.pushReplacementNamed(context, HOME);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Login"),
                  Container(
                    padding: EdgeInsets.all(24),
                    child: Form(
                      child: Column(
                        spacing: 8,
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(labelText: "Email"),
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(labelText: "Password"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context).add(
                                LoginSubmited(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            },
                            child: Text("Login"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/components/buttons.dart';
import 'package:onlineshop_app/core/components/input_field.dart';
import 'package:onlineshop_app/core/components/spaces.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/data/datasources/auth_local_datasource.dart';
import 'package:onlineshop_app/data/datasources/request/login_request_model.dart';
import 'package:onlineshop_app/presentation/auth/bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        children: [
          const Text(
            'Login Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            'Hello, welcome back to our account',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceHeight(40),
          InputField.email(
            controller: _emailController,
            label: 'Email',
          ),
          InputField.password(
            controller: _passwordController,
            label: 'Password',
          ),
          const SpaceHeight(20),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded: (data) {
                  AuthLocalDatasource().saveAuthData(data);
                  context.goNamed(
                    RouteName.root,
                  );
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.red,
                      content: Text(message),
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () {
                      context.read<LoginBloc>().add(
                            LoginEvent.login(LoginRequestModel(
                              email: _emailController.text,
                              password: _passwordController.text,
                            )),
                          );
                    },
                    label: 'Login',
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
              // return Button.filled(
              //   onPressed: () {
              //     // context.goNamed(
              //     //   RouteConstants.root,
              //     //   pathParameters: PathParameters().toMap(),
              //     // );
              //     context.read<LoginBloc>().add(
              //           LoginEvent.login(
              //             email: emailController.text,
              //             password: passwordController.text,
              //           ),
              //         );
              //   },
              //   label: 'Login',
              // );
            },
          ),
        ],
      ),
    );
  }
}

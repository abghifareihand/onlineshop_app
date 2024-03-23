import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/components/buttons.dart';
import 'package:onlineshop_app/core/components/dialog.dart';
import 'package:onlineshop_app/core/components/loading.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/presentation/profile/bloc/logout/logout_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button.filled(
              onPressed: () {
                context.read<LogoutBloc>().add(const LogoutEvent.logout());
              },
              child: BlocConsumer<LogoutBloc, LogoutState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (message) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            title: 'Logout Failed',
                            message: message,
                          );
                        },
                      );
                    },
                    loaded: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(message),
                        ),
                      );
                      context.goNamed(RouteName.splash);
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const Text(
                        'Logout',
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      );
                    },
                    loading: () {
                      return const LoadingSpinkit();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
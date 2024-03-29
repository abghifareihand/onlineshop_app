import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/components/buttons.dart';
import 'package:onlineshop_app/core/components/loading.dart';
import 'package:onlineshop_app/core/components/spaces.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/presentation/profile/bloc/logout/logout_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          ListTile(
            leading: const Icon(
              Icons.person_3_outlined,
              color: AppColors.primary,
            ),
            title: const Text(
              'Account',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.shopping_bag_outlined,
              color: AppColors.primary,
            ),
            title: const Text(
              'Pesanan',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              context.pushNamed(
                RouteName.orderList,
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.location_on_outlined,
              color: AppColors.primary,
            ),
            title: const Text(
              'Alamat',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.credit_card_outlined,
              color: AppColors.primary,
            ),
            title: const Text(
              'Pembayaran',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {},
          ),
          const SpaceHeight(16),
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message) {
                  context.goNamed(RouteName.login);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(message),
                    ),
                  );
                },
                loaded: (message) {
                  context.goNamed(RouteName.splash);
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () {
                      context
                          .read<LogoutBloc>()
                          .add(const LogoutEvent.logout());
                    },
                    label: 'Logout',
                  );
                },
                loading: () {
                  return const LoadingSpinkitColor();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

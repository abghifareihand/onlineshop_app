import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/core/router/app_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () => context.goNamed(
        RouteName.root,
      ),
    );

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text(
          'Code with Abghi',
          style: greyTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

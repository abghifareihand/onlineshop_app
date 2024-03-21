import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/presentation/auth/pages/login_page.dart';
import 'package:onlineshop_app/presentation/auth/pages/splash_page.dart';
import 'package:onlineshop_app/presentation/dashboard/dashboard_page.dart';
part 'route_name.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteName.splashPath,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: RouteName.splash,
        path: RouteName.splashPath,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: RouteName.login,
        path: RouteName.loginPath,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: RouteName.root,
        path: RouteName.rootPath,
        builder: (context, state) {
          return DashboardPage(
            key: state.pageKey,
            currentTab: 0,
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    },
  );
}

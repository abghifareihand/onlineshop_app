import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/presentation/address/models/address_model.dart';
import 'package:onlineshop_app/presentation/address/pages/add_address_page.dart';
import 'package:onlineshop_app/presentation/address/pages/address_page.dart';
import 'package:onlineshop_app/presentation/address/pages/edit_address_page.dart';
import 'package:onlineshop_app/presentation/auth/pages/login_page.dart';
import 'package:onlineshop_app/presentation/auth/pages/splash_page.dart';
import 'package:onlineshop_app/presentation/cart/pages/cart_page.dart';
import 'package:onlineshop_app/presentation/cart/pages/checkout_page.dart';
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
        routes: [
          GoRoute(
            name: RouteName.cart,
            path: RouteName.cartPath,
            builder: (context, state) => const CartPage(),
            routes: [
              GoRoute(
                name: RouteName.checkout,
                path: RouteName.checkoutPath,
                builder: (context, state) => const CheckoutPage(),
              ),
            ],
          ),
          GoRoute(
            name: RouteName.address,
            path: RouteName.addressPath,
            builder: (context, state) => const AddressPage(),
            routes: [
              GoRoute(
                name: RouteName.addAddress,
                path: RouteName.addAddressPath,
                builder: (context, state) => const AddAddressPage(),
              ),
              GoRoute(
                name: RouteName.editAddress,
                path: RouteName.editAddressPath,
                builder: (context, state) {
                  final args = state.extra as AddressModel;
                  return EditAddressPage(data: args);
                },
              ),
            ],
          ),
        ],
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

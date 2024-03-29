import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/presentation/address/models/address_model.dart';
import 'package:onlineshop_app/presentation/address/pages/add_address_page.dart';
import 'package:onlineshop_app/presentation/address/pages/address_page.dart';
import 'package:onlineshop_app/presentation/address/pages/edit_address_page.dart';
import 'package:onlineshop_app/presentation/auth/pages/login_page.dart';
import 'package:onlineshop_app/presentation/auth/pages/splash_page.dart';
import 'package:onlineshop_app/presentation/dashboard/dashboard_page.dart';
import 'package:onlineshop_app/presentation/order/pages/cart_page.dart';
import 'package:onlineshop_app/presentation/order/pages/history_order_page.dart';
import 'package:onlineshop_app/presentation/order/pages/order_detail_page.dart';
import 'package:onlineshop_app/presentation/order/pages/payment_detail_page.dart';
import 'package:onlineshop_app/presentation/order/pages/payment_waiting_page.dart';
import 'package:onlineshop_app/presentation/order/pages/shipping_detail_page.dart';
import 'package:onlineshop_app/presentation/order/pages/tracking_order_page.dart';
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
            name: RouteName.orderList,
            path: RouteName.orderListPath,
            builder: (context, state) => const HistoryOrderPage(),
            routes: [
              GoRoute(
                name: RouteName.trackingOrder,
                path: RouteName.trackingOrderPath,
                builder: (context, state) {
                  final args = state.extra as int;
                  return TrackingOrderPage(orderId: args);
                },
                routes: [
                  GoRoute(
                    name: RouteName.shippingDetail,
                    path: RouteName.shippingDetailPath,
                    builder: (context, state) {
                      final args = state.extra as String;
                      return ShippingDetailPage(
                        resi: args
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            name: RouteName.cart,
            path: RouteName.cartPath,
            builder: (context, state) => const CartPage(),
            routes: [
              GoRoute(
                name: RouteName.orderDetail,
                path: RouteName.orderDetailPath,
                builder: (context, state) => const OrderDetailPage(),
                routes: [
                  GoRoute(
                    name: RouteName.paymentDetail,
                    path: RouteName.paymentDetailPath,
                    builder: (context, state) => const PaymentDetailPage(),
                    routes: [
                      GoRoute(
                        name: RouteName.paymentWaiting,
                        path: RouteName.paymentWaitingPath,
                        builder: (context, state) {
                          final args = state.extra as int;
                          return PaymentWaitingPage(orderId: args);
                        },
                      ),
                    ],
                  ),
                ],
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

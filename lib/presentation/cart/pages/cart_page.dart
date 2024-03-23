import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/components/loading.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/core/constants/formatter.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/data/datasources/auth_local_datasource.dart';
import 'package:onlineshop_app/presentation/cart/bloc/cart/cart_bloc.dart';
import 'package:onlineshop_app/presentation/cart/widgets/cart_tile.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const LoadingSpinkit();
            },
            loaded: (products) {
              int totalPrice = 0;
              for (var product in products) {
                totalPrice += product.quantity * product.product.price!;
              }
              if (products.isEmpty) {
                return const Center(
                  child: Text('Cart Empty'),
                );
              }
              return ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, index) => CartTile(
                      data: products[index],
                    ),
                    separatorBuilder: (context, index) =>
                        const SpaceHeight(16.0),
                  ),
                  const SpaceHeight(50.0),
                  Row(
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        totalPrice.currencyFormatRp,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SpaceHeight(40.0),
                  Button.filled(
                    onPressed: () async {
                      final isAuth = await AuthLocalDatasource().isLogin();
                      debugPrint('isAuth: $isAuth');

                      if (context.mounted) {
                        // Memeriksa apakah widget masih ada di pohon widget
                        if (!isAuth) {
                          context.pushNamed(RouteName.login);
                        } else {
                          context.goNamed(RouteName.checkout);
                        }
                      }
                    },
                    child: Text(
                      'Checkout (${products.length})',
                      style: const TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

//  BlocBuilder<CartBloc, CartState>(
//                 builder: (context, state) {
//                   return state.maybeWhen(
//                     orElse: () {
//                       return const LoadingSpinkit();
//                     },
//                     loaded: (products) {
//                       if (products.isEmpty) {
//                         return const Center(child: Text('No Cart'));
//                       }
//                       return ListView.separated(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: products.length,
//                         itemBuilder: (context, index) => CartTile(
//                           data: products[index],
//                         ),
//                         separatorBuilder: (context, index) =>
//                             const SpaceHeight(16.0),
//                       );
//                     },
//                   );
//                 },
//               ),
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/constants/formatter.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/data/datasources/auth_local_datasource.dart';
import 'package:onlineshop_app/presentation/order/widgets/cart_tile.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../home/bloc/checkout/checkout_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  loaded: (checkout, _, __, ___, ____, _____) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: checkout.length,
                      itemBuilder: (context, index) => CartTile(
                        data: checkout[index],
                      ),
                      separatorBuilder: (context, index) =>
                          const SpaceHeight(16.0),
                    );
                  });
            },
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
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  final total = state.maybeWhen(
                    orElse: () => 0,
                    loaded: (checkout, _, __, ___, ____, _____) {
                      return checkout.fold<int>(
                        0,
                        (previousValue, element) =>
                            previousValue +
                            (element.quantity * element.product.price!),
                      );
                    },
                  );
                  return Text(
                    total.currencyFormatRp,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
          const SpaceHeight(40.0),
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              final totalQty = state.maybeWhen(
                orElse: () => 0,
                loaded: (checkout, _, __, ___, ____, _____) {
                  return checkout.fold<int>(
                    0,
                    (previousValue, element) =>
                        previousValue + element.quantity,
                  );
                },
              );
              return Button.filled(
                onPressed: () async {
                  final isAuth = await AuthLocalDatasource().isLogin();
                  if (!isAuth) {
                    context.pushNamed(
                      RouteName.login,
                    );
                  } else {
                    context.goNamed(
                      RouteName.address,
                      
                    );
                  }
                },
                label: 'Checkout ($totalQty)',
              );
              
            },
          ),
        ],
      ),
    );
  }
}

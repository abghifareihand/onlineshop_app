import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/core/constants/formatter.dart';
import 'package:onlineshop_app/core/constants/images.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:onlineshop_app/presentation/home/models/product_quantity.dart';
import 'package:onlineshop_app/presentation/order/bloc/order/order_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../models/bank_account_model.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/payment_method.dart';

class PaymentDetailPage extends StatelessWidget {
  const PaymentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
  
    List<BankAccountModel> banksLimit = [banks[0], banks[1]];

    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // Row(
          //   children: [
          //     const Icon(Icons.schedule),
          //     const SpaceWidth(12.0),
          //     const Flexible(
          //       child: Text(
          //         'Selesaikan Pembayaran Dalam',
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //     ),
          //     const SpaceWidth(12.0),
          //     CountdownTimer(
          //       minute: 120,
          //       onTimerCompletion: () {},
          //     ),
          //   ],
          // ),
          // const SpaceHeight(30.0),
          Row(
            children: [
              const Text(
                'Metode Pembayaran',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Lihat semua',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SpaceHeight(20.0),
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              final paymentVaName = state.maybeWhen(
                orElse: () => '',
                loaded: (_, __, ___, ____, _____, paymentVaName) {
                  return paymentVaName;
                },
              );
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => PaymentMethod(
                  isActive: paymentVaName == banksLimit[index].code,
                  data: banksLimit[index],
                  onTap: () {
                    context.read<CheckoutBloc>().add(
                        CheckoutEvent.addPaymentMethod(banksLimit[index].code));
                  },
                ),
                separatorBuilder: (context, index) => const SpaceHeight(14.0),
                itemCount: banksLimit.length,
              );
            },
          ),
          const SpaceHeight(36.0),
          const Divider(),
          const SpaceHeight(8.0),
          const Text(
            'Ringkasan Pembayaran',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceHeight(12.0),
          Row(
            children: [
              const Text(
                'Total Belanja',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  final subtotal = state.maybeWhen(
                    orElse: () => 0,
                    loaded: (products, _, __, ___, ____, ______) =>
                        products.fold<int>(
                      0,
                      (previousValue, element) =>
                          previousValue +
                          (element.product.price! * element.quantity),
                    ),
                  );
                  return Text(
                    subtotal.currencyFormatRp,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
          const SpaceHeight(5.0),
          Row(
            children: [
              const Text(
                'Biaya Kirim',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  final shippingCost = state.maybeWhen(
                    orElse: () => 0,
                    loaded: (_, __, ___, ____, shippingCost, ______) =>
                        shippingCost,
                  );
                  return Text(
                    shippingCost.currencyFormatRp,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
          const SpaceHeight(8.0),
          const Divider(),
          const SpaceHeight(24.0),
          Row(
            children: [
              const Text(
                'Total Tagihan',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  final total = state.maybeWhen(
                    orElse: () => 0,
                    loaded: (products, _, __, ___, shippingCost, ______) =>
                        products.fold<int>(
                          0,
                          (previousValue, element) =>
                              previousValue +
                              (element.product.price! * element.quantity),
                        ) +
                        shippingCost,
                  );
                  return Text(
                    total.currencyFormatRp,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
          const SpaceHeight(20.0),

          BlocListener<OrderBloc, OrderState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loaded: (orderResponseModel) {
                  context.pushNamed(
                    RouteName.paymentWaiting,
                    extra: orderResponseModel.data!.id
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
            child: BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                final paymentMethod = state.maybeWhen(
                  orElse: () => '',
                  loaded: (_, __, paymentMethod, ___, ____, ______) =>
                      paymentMethod,
                );

                final shippingService = state.maybeWhen(
                  orElse: () => '',
                  loaded: (_, __, ___, shippingService, ____, ______) =>
                      shippingService,
                );

                final shippingCost = state.maybeWhen(
                  orElse: () => 0,
                  loaded: (_, __, ___, ____, shippingCost, ______) =>
                      shippingCost,
                );

                final paymentVaName = state.maybeWhen(
                  orElse: () => '',
                  loaded: (_, __, ___, ____, _____, paymentVaName) =>
                      paymentVaName,
                );

                final products = state.maybeWhen(
                  orElse: () => [],
                  loaded: (products, _, __, ___, ____, ______) => products,
                );

                final addressId = state.maybeWhen(
                  orElse: () => 0,
                  loaded: (_, addressId, __, ___, ____, ______) => addressId,
                );

                return Button.filled(
                  disabled: paymentMethod == '',
                  onPressed: () {
                    context.read<OrderBloc>().add(
                          OrderEvent.doOrder(
                            addressId: addressId,
                            paymentMethod: paymentMethod,
                            shippingService: shippingService,
                            shippingCost: shippingCost,
                            paymentVaName: paymentVaName,
                            products: products as List<ProductQuantity>,
                          ),
                        );
                  },
                  label: 'Bayar Sekarang',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

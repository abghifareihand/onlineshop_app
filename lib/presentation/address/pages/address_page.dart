import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/constants/formatter.dart';
import 'package:onlineshop_app/presentation/home/bloc/checkout/checkout_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/router/app_router.dart';
import '../bloc/address/address_bloc.dart';
import '../widgets/address_tile.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(const AddressEvent.getAddress());
  }

  @override
  Widget build(BuildContext context) {
    // int selectedIndex = addresses.indexWhere((element) => element.isPrimary);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed(
                RouteName.cart,
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text(
            'Pilih atau tambahkan alamat pengiriman',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SpaceHeight(20.0),
          BlocBuilder<AddressBloc, AddressState>(
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }, loaded: (addresses) {
                return BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    final addressId = state.maybeWhen(
                      orElse: () => 0,
                      loaded: (checkout, addressId, __, ___, ____, _____) {
                        return addressId;
                      },
                    );
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: addresses.length,
                      itemBuilder: (context, index) => AddressTile(
                        isSelected: addressId == addresses[index].id,
                        data: addresses[index],
                        onTap: () {
                          context.read<CheckoutBloc>().add(
                                CheckoutEvent.addAddressId(
                                  addresses[index].id!,
                                ),
                              );
                        },
                        onEditTap: () {
                          context.goNamed(
                            RouteName.editAddress,
                            extra: addresses[index],
                          );
                        },
                      ),
                      separatorBuilder: (context, index) =>
                          const SpaceHeight(16.0),
                    );
                  },
                );
              });
            },
          ),
          const SpaceHeight(40.0),
          Button.outlined(
            onPressed: () {
              context.goNamed(
                RouteName.addAddress,
              );
            },
            label: 'Add address',
          ),
          const SpaceHeight(50.0),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtotal (Estimasi)',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  20000.currencyFormatRp,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SpaceHeight(12.0),
            Button.filled(
              onPressed: () {
                context.goNamed(
                  RouteName.orderDetail,
                );
              },
              label: 'Lanjutkan',
            ),
          ],
        ),
      ),
    );
  }
}

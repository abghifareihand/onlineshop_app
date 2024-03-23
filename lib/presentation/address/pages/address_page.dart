import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/components/loading.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/core/constants/formatter.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/presentation/address/bloc/address/address_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../models/address_model.dart';
import '../widgets/address_tile.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  // final List<AddressModel> addresses = [
  //   AddressModel(
  //     country: 'Indonesia',
  //     firstName: 'Saiful',
  //     lastName: 'Bahri',
  //     address: 'Jl. Merdeka No. 123',
  //     city: 'Jakarta Selatan',
  //     province: 'DKI Jakarta',
  //     zipCode: 12345,
  //     phoneNumber: '08123456789',
  //     isPrimary: true,
  //   ),
  //   AddressModel(
  //     country: 'Indonesia',
  //     firstName: 'Saiful',
  //     lastName: '',
  //     address: 'Jl. Cendrawasih No. 456',
  //     city: 'Bandung',
  //     province: 'Jawa Barat',
  //     zipCode: 67890,
  //     phoneNumber: '08987654321',
  //   ),
  // ];

  @override
  void initState() {
    context.read<AddressBloc>().add(const AddressEvent.getAddress());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // int selectedIndex = addresses.indexWhere((element) => element.isPrimary);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
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
              return state.maybeWhen(
                orElse: () {
                  return const LoadingSpinkit();
                },
                loaded: (addressResponse) {
                  final address = addressResponse.data;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: address!.length,
                    itemBuilder: (context, index) => AddressTile(
                      isSelected: false,
                      data: address[index],
                      onTap: () {
                        // selectedIndex = index;
                        // setState(() {});
                      },
                      onEditTap: () {
                        context.goNamed(
                          RouteName.editAddress,
                        );
                      },
                    ),
                    separatorBuilder: (context, index) =>
                        const SpaceHeight(16.0),
                  );
                },
              );
            },
          ),
          const SpaceHeight(40.0),
          Button.outlined(
            onPressed: () {
              context.goNamed(
                RouteName.addAddress,
              );
            },
            child: const Text(
              'Add address',
              style: TextStyle(
                color: AppColors.primary,
              ),
            ),
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
              onPressed: () {},
              child: const Text(
                'Continue',
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/components/dialog.dart';
import 'package:onlineshop_app/core/components/loading.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/data/datasources/request/address_request_model.dart';
import 'package:onlineshop_app/data/models/city_response_model.dart';
import 'package:onlineshop_app/data/models/province_response_model.dart';
import 'package:onlineshop_app/data/models/subdistrict_response_model.dart';
import 'package:onlineshop_app/presentation/address/bloc/add_address/add_address_bloc.dart';
import 'package:onlineshop_app/presentation/address/bloc/city/city_bloc.dart';
import 'package:onlineshop_app/presentation/address/bloc/province/province_bloc.dart';
import 'package:onlineshop_app/presentation/address/bloc/subdistrict/subdistrict_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_dropdown.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Province selectedProvince = Province(
    provinceId: '',
    province: '',
  );

  City selectedCity = City(
    cityId: '',
  );

  Subdistrict selectedSubdistrict = Subdistrict(
    subdistrictId: '',
  );

  @override
  void initState() {
    context.read<ProvinceBloc>().add(const ProvinceEvent.getProvince());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Adress'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const SpaceHeight(24.0),
          CustomTextField(
            controller: _nameController,
            label: 'Nama',
          ),
          const SpaceHeight(24.0),
          CustomTextField(
            controller: _addressController,
            label: 'Alamat jalan',
          ),
          const SpaceHeight(24.0),
          BlocBuilder<ProvinceBloc, ProvinceState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return CustomDropdown(
                    value: '-',
                    items: const ['-'],
                    label: 'Provinsi',
                    onChanged: (value) {},
                  );
                },
                loading: () {
                  return const LoadingSpinkit();
                },
                loaded: (provinceResponse) {
                  final province = provinceResponse.rajaongkir!.results!;
                  selectedProvince = province.first;
                  return CustomDropdown<Province>(
                    value: selectedProvince,
                    items: province,
                    label: 'Provinsi',
                    onChanged: (value) {
                      setState(() {
                        selectedProvince = value!;
                        context.read<CityBloc>().add(
                            CityEvent.getCity(selectedProvince.provinceId!));
                      });
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          BlocBuilder<CityBloc, CityState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return CustomDropdown(
                    value: '-',
                    items: const ['-'],
                    label: 'Kota/Kabupaten',
                    onChanged: (value) {},
                  );
                },
                loading: () {
                  return const LoadingSpinkit();
                },
                loaded: (cityResponse) {
                  final city = cityResponse.rajaongkir!.results!;
                  selectedCity = city.first;
                  return CustomDropdown<City>(
                    value: selectedCity,
                    items: city,
                    label: 'Kota/Kabupaten',
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value!;
                        context.read<SubdistrictBloc>().add(
                              SubdistrictEvent.getSubdistrict(
                                  selectedCity.cityId!),
                            );
                      });
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          BlocBuilder<SubdistrictBloc, SubdistrictState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return CustomDropdown(
                    value: '-',
                    items: const ['-'],
                    label: 'Kecamatan',
                    onChanged: (value) {},
                  );
                },
                loading: () {
                  return const LoadingSpinkit();
                },
                loaded: (subdistrictResponse) {
                  final subdistrict = subdistrictResponse.rajaongkir!.results!;
                  selectedSubdistrict = subdistrict.first;
                  return CustomDropdown<Subdistrict>(
                    value: selectedSubdistrict,
                    items: subdistrict,
                    label: 'Kecamatan',
                    onChanged: (value) {
                      setState(() {
                        selectedSubdistrict = value!;
                      });
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          CustomTextField(
            controller: _zipCodeController,
            label: 'Kode Pos',
          ),
          const SpaceHeight(24.0),
          CustomTextField(
            controller: _phoneController,
            label: 'No Handphone',
          ),
          const SpaceHeight(24.0),
          Button.filled(
            onPressed: () {
              final addAddress = AddressRequestModel(
                name: _nameController.text,
                fullAddress: _addressController.text,
                provId: selectedProvince.province,
                cityId: selectedCity.cityName,
                districtId: selectedSubdistrict.subdistrictName,
                postalCode: _zipCodeController.text,
                phone: _phoneController.text,
                isDefault: true,
              );
              context
                  .read<AddAddressBloc>()
                  .add(AddAddressEvent.addAddress(addAddress));
            },
            child: BlocConsumer<AddAddressBloc, AddAddressState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  loaded: (message) {
                    context.goNamed(RouteName.root);
                  },
                  error: (message) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                          title: 'Add Address Failed',
                          message: message,
                        );
                      },
                    );
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const Text(
                      'Tambah Alamat',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    );
                  },
                  loading: () {
                    return const LoadingSpinkit();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

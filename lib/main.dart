import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/data/datasources/address_remote_datasource.dart';
import 'package:onlineshop_app/data/datasources/auth_remote_datasource.dart';
import 'package:onlineshop_app/data/datasources/category_remote_datasource.dart';
import 'package:onlineshop_app/data/datasources/product_remote_datasource.dart';
import 'package:onlineshop_app/data/datasources/rajaongkir_remote_datasource.dart';
import 'package:onlineshop_app/presentation/address/bloc/add_address/add_address_bloc.dart';
import 'package:onlineshop_app/presentation/address/bloc/address/address_bloc.dart';
import 'package:onlineshop_app/presentation/address/bloc/city/city_bloc.dart';
import 'package:onlineshop_app/presentation/address/bloc/province/province_bloc.dart';
import 'package:onlineshop_app/presentation/address/bloc/subdistrict/subdistrict_bloc.dart';
import 'package:onlineshop_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:onlineshop_app/presentation/auth/bloc/register/register_bloc.dart';
import 'package:onlineshop_app/presentation/cart/bloc/cart/cart_bloc.dart';
import 'package:onlineshop_app/presentation/home/bloc/category/category_bloc.dart';
import 'package:onlineshop_app/presentation/home/bloc/product/product_bloc.dart';
import 'package:onlineshop_app/presentation/home/bloc/product_category/product_category_bloc.dart';
import 'package:onlineshop_app/presentation/profile/bloc/logout/logout_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(CategoryRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddressBloc(AddressRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddAddressBloc(AddressRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ProductCategoryBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ProvinceBloc(RajaongkirRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CityBloc(RajaongkirRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => SubdistrictBloc(RajaongkirRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          textTheme: GoogleFonts.dmSansTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.primary,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.black,
            ),
            centerTitle: true,
            shape: Border(
              bottom: BorderSide(
                color: AppColors.black.withOpacity(0.05),
              ),
            ),
          ),
        ),
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,
      ),
    );
  }
}

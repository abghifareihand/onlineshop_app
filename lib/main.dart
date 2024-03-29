import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onlineshop_app/core/constants/colors.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/data/datasources/address_remote_datasource.dart';
import 'package:onlineshop_app/data/datasources/auth_remote_datasource.dart';
import 'package:onlineshop_app/data/datasources/category_remote_datasource.dart';
import 'package:onlineshop_app/data/datasources/firebase_message_remote_datasource.dart';
import 'package:onlineshop_app/data/datasources/order_remote_datasource.dart';
import 'package:onlineshop_app/data/datasources/product_remote_datasource.dart';
import 'package:onlineshop_app/data/datasources/rajaongkir_remote_datasource.dart';
import 'package:onlineshop_app/firebase_options.dart';
import 'package:onlineshop_app/presentation/address/bloc/add_address/add_address_bloc.dart';
import 'package:onlineshop_app/presentation/address/bloc/address/address_bloc.dart';
import 'package:onlineshop_app/presentation/address/bloc/city/city_bloc.dart';
import 'package:onlineshop_app/presentation/address/bloc/province/province_bloc.dart';
import 'package:onlineshop_app/presentation/address/bloc/subdistrict/subdistrict_bloc.dart';
import 'package:onlineshop_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:onlineshop_app/presentation/auth/bloc/register/register_bloc.dart';
import 'package:onlineshop_app/presentation/home/bloc/category/category_bloc.dart';
import 'package:onlineshop_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:onlineshop_app/presentation/home/bloc/product/product_bloc.dart';
import 'package:onlineshop_app/presentation/home/bloc/product_category/product_category_bloc.dart';
import 'package:onlineshop_app/presentation/order/bloc/cost/cost_bloc.dart';
import 'package:onlineshop_app/presentation/order/bloc/history_order/history_order_bloc.dart';
import 'package:onlineshop_app/presentation/order/bloc/order/order_bloc.dart';
import 'package:onlineshop_app/presentation/order/bloc/order_detail/order_detail_bloc.dart';
import 'package:onlineshop_app/presentation/order/bloc/status_order/status_order_bloc.dart';
import 'package:onlineshop_app/presentation/order/bloc/tracking/tracking_bloc.dart';
import 'package:onlineshop_app/presentation/profile/bloc/logout/logout_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessageRemoteDatasource().initNotification();
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
          create: (context) => CostBloc(RajaongkirRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => HistoryOrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => OrderDetailBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => StatusOrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => TrackingBloc(RajaongkirRemoteDatasource()),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/components/buttons.dart';
import 'package:onlineshop_app/core/components/loading.dart';
import 'package:onlineshop_app/core/constants/images.dart';
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/presentation/order/bloc/order_detail/order_detail_bloc.dart';

import '../../../core/components/spaces.dart';
import '../../home/models/product_model.dart';
import '../../home/models/store_model.dart';
import '../models/track_record_model.dart';
import '../widgets/product_tile.dart';
import '../widgets/tracking_horizontal.dart';

class TrackingOrderPage extends StatefulWidget {
  final int orderId;
  const TrackingOrderPage({
    super.key,
    required this.orderId,
  });

  @override
  State<TrackingOrderPage> createState() => _TrackingOrderPageState();
}

class _TrackingOrderPageState extends State<TrackingOrderPage> {
  // final List<ProductModel> orders = [
  //   ProductModel(
  //     images: [
  //       Images.placeholder,
  //       Images.placeholder,
  //       Images.placeholder,
  //     ],
  //     name: 'Earphone',
  //     price: 320000,
  //     stock: 20,
  //     description:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
  //     store: StoreModel(
  //       name: 'CWB Online Store',
  //       type: StoreEnum.officialStore,
  //       imageUrl: 'https://avatars.githubusercontent.com/u/534678?v=4',
  //     ),
  //   ),
  //   ProductModel(
  //     images: [
  //       Images.placeholder,
  //       Images.placeholder,
  //       Images.placeholder,
  //     ],
  //     name: 'Sepatu Nike',
  //     price: 2200000,
  //     stock: 20,
  //     description:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
  //     store: StoreModel(
  //       name: 'CWB Online Store',
  //       type: StoreEnum.officialStore,
  //       imageUrl: 'https://avatars.githubusercontent.com/u/534678?v=4',
  //     ),
  //   ),
  // ];
  final List<TrackRecordModel> trackRecords = [
    TrackRecordModel(
      title: 'Pesanan Anda belum dibayar',
      status: TrackRecordStatus.belumBayar,
      isActive: true,
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    TrackRecordModel(
      title: 'Pesanan Anda sedang disiapkan',
      status: TrackRecordStatus.dikemas,
      isActive: true,
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    TrackRecordModel(
      title: 'Pesanan Anda dalam pengiriman',
      status: TrackRecordStatus.dikirim,
      isActive: true,
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    TrackRecordModel(
      title: 'Pesanan Anda telah tiba',
      status: TrackRecordStatus.selesai,
      isActive: true,
      updatedAt: DateTime.now(),
    ),
  ];
  @override
  void initState() {
    context
        .read<OrderDetailBloc>()
        .add(OrderDetailEvent.getOrderDetail(widget.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tracking Orders'),
      ),
      body: BlocBuilder<OrderDetailBloc, OrderDetailState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const LoadingSpinkitColor();
            },
            loaded: (orderDetail) {
              return ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orderDetail.data!.orderItems!.length,
                    itemBuilder: (context, index) => ProductTile(
                      data: orderDetail.data!.orderItems![index],
                    ),
                    separatorBuilder: (context, index) =>
                        const SpaceHeight(16.0),
                  ),
                  const SpaceHeight(40.0),
                  // TrackingHorizontal(trackRecords: trackRecords),
                  Button.outlined(
                    onPressed: () {
                      context.pushNamed(
                        RouteName.shippingDetail,
                        extra: orderDetail.data!.shippingResi,
                      );
                    },
                    label: 'Detail pelacakan pengiriman',
                  ),
                  const SpaceHeight(20.0),
                  const Text(
                    'Info Pengiriman',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SpaceHeight(20.0),
                  const Text(
                    'Alamat Pesanan',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    orderDetail.data!.address!.fullAddress!,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SpaceHeight(16.0),
                  const Text(
                    'Penerima',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    orderDetail.data!.user!.name!,
                    style: const TextStyle(
                      fontSize: 16,
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

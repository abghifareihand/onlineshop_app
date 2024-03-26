import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:onlineshop_app/data/datasources/order_remote_datasource.dart';
import 'package:onlineshop_app/data/datasources/request/order_request_model.dart';
import 'package:onlineshop_app/data/models/order_response_model.dart';
import 'package:onlineshop_app/presentation/home/models/product_quantity.dart';

part 'order_bloc.freezed.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRemoteDatasource _orderRemoteDatasource;
  OrderBloc(
    this._orderRemoteDatasource,
  ) : super(const _Initial()) {
    on<_DoOrder>((event, emit) async {
      emit(const _Loading());
      final orderRequestData = OrderRequestModel(
          addressId: event.addressId,
          paymentMethod: event.paymentMethod,
          shippingService: event.shippingService,
          shippingCost: event.shippingCost,
          paymentVaName: event.paymentVaName,
          subtotal: 0,
          totalCost: 0,
          items: event.products
              .map((e) => Item(productId: e.product.id!, quantity: e.quantity))
              .toList());
      final result = await _orderRemoteDatasource.order(orderRequestData);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}

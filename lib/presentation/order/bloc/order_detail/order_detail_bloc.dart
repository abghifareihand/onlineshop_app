import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:onlineshop_app/data/datasources/order_remote_datasource.dart';
import 'package:onlineshop_app/data/models/order_detail_response_model.dart';

part 'order_detail_bloc.freezed.dart';
part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final OrderRemoteDatasource _orderRemoteDatasource;
  OrderDetailBloc(
    this._orderRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetOrderDetail>((event, emit) async {
     emit(const _Loading());
      final result = await _orderRemoteDatasource.getOrderById(event.orderId);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlineshop_app/data/datasources/order_remote_datasource.dart';

part 'status_order_event.dart';
part 'status_order_state.dart';
part 'status_order_bloc.freezed.dart';

class StatusOrderBloc extends Bloc<StatusOrderEvent, StatusOrderState> {
  final OrderRemoteDatasource _orderRemoteDatasource;
  StatusOrderBloc(
    this._orderRemoteDatasource,
  ) : super(const _Initial()) {
    on<_CheckPaymentStatus>((event, emit) async {
      emit(const _Loading());
      final result = await _orderRemoteDatasource.checkPaymentStatus(event.orderId);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}

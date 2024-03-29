
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:onlineshop_app/data/datasources/order_remote_datasource.dart';
import 'package:onlineshop_app/data/models/history_order_response_model.dart';

part 'history_order_bloc.freezed.dart';
part 'history_order_event.dart';
part 'history_order_state.dart';

class HistoryOrderBloc extends Bloc<HistoryOrderEvent, HistoryOrderState> {
  final OrderRemoteDatasource _orderRemoteDatasource;
  HistoryOrderBloc(
    this._orderRemoteDatasource,
  ) : super(const _Initial()) {
    on<HistoryOrderEvent>((event, emit) async {
     emit(const _Loading());
      final result = await _orderRemoteDatasource.getOrders();
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}

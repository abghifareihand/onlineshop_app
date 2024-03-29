import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:onlineshop_app/data/datasources/rajaongkir_remote_datasource.dart';
import 'package:onlineshop_app/data/models/tracking_response_model.dart';

part 'tracking_bloc.freezed.dart';
part 'tracking_event.dart';
part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final RajaongkirRemoteDatasource _rajaongkirRemoteDatasource;
  TrackingBloc(
    this._rajaongkirRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetTracking>((event, emit) async {
      emit(const _Loading());
      final result = await _rajaongkirRemoteDatasource.getWaybill(event.noResi, event.kurir);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}

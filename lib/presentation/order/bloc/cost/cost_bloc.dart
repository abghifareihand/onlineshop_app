import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:onlineshop_app/data/datasources/cost_response_model.dart';
import 'package:onlineshop_app/data/datasources/rajaongkir_remote_datasource.dart';

part 'cost_bloc.freezed.dart';
part 'cost_event.dart';
part 'cost_state.dart';

class CostBloc extends Bloc<CostEvent, CostState> {
  final RajaongkirRemoteDatasource _rajaongkirRemoteDatasource;
  CostBloc(
    this._rajaongkirRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetCost>((event, emit) async {
      emit(const _Loading());
      final result = await _rajaongkirRemoteDatasource.getCost(
        event.origin,
        event.destination,
        'jne',
      );
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}

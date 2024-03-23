
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:onlineshop_app/data/datasources/rajaongkir_remote_datasource.dart';
import 'package:onlineshop_app/data/models/province_response_model.dart';

part 'province_bloc.freezed.dart';
part 'province_event.dart';
part 'province_state.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  final RajaongkirRemoteDatasource _rajaongkirRemoteDatasource;
  ProvinceBloc(
    this._rajaongkirRemoteDatasource,
  ) : super(const _Initial()) {
    on<ProvinceEvent>((event, emit) async {
     emit(const _Loading());
      final result = await _rajaongkirRemoteDatasource.getProvince();
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:onlineshop_app/data/datasources/address_remote_datasource.dart';
import 'package:onlineshop_app/data/models/address_response_model.dart';

part 'address_bloc.freezed.dart';
part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRemoteDatasource _addressRemoteDatasource;
  AddressBloc(
    this._addressRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetAddress>((event, emit) async {
      emit(const _Loading());
      final result = await _addressRemoteDatasource.getAddress();
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data.data ?? [])),
      );
    });
  }
}

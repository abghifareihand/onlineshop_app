import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:onlineshop_app/data/datasources/product_remote_datasource.dart';
import 'package:onlineshop_app/data/models/product_response_model.dart';

part 'product_category_bloc.freezed.dart';
part 'product_category_event.dart';
part 'product_category_state.dart';

class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  ProductCategoryBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetProductByCategory>((event, emit) async {
      emit(const _Loading());
      final result = await _productRemoteDatasource.getProductByCategory(1);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}

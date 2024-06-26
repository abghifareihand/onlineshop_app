part of 'product_bloc.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;
  const factory ProductState.loaded(ProductResponseModel productResponse) = _Loaded;
  const factory ProductState.error(String message) = _Error;
}

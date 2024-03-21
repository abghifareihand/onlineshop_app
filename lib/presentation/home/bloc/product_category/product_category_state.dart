part of 'product_category_bloc.dart';

@freezed
class ProductCategoryState with _$ProductCategoryState {
  const factory ProductCategoryState.initial() = _Initial;
  const factory ProductCategoryState.loading() = _Loading;
  const factory ProductCategoryState.loaded(ProductResponseModel productResponse) = _Loaded;
  const factory ProductCategoryState.error(String message) = _Error;

}

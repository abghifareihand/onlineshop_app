part of 'product_category_bloc.dart';

@freezed
class ProductCategoryEvent with _$ProductCategoryEvent {
  const factory ProductCategoryEvent.started() = _Started;
  const factory ProductCategoryEvent.getProductByCategory() = _GetProductByCategory;
}
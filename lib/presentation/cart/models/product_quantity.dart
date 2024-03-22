import 'package:onlineshop_app/data/models/product_response_model.dart';

class ProductQuantity {
  final Product product;
  int quantity;

  ProductQuantity({
    required this.product,
    required this.quantity,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductQuantity &&
        other.product == product &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;

  ProductQuantity copyWith({
    Product? product,
    int? quantity,
  }) {
    return ProductQuantity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}

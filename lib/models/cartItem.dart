import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    @required this.product,
    @required this.quantity,
  });
}

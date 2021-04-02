import 'package:flutter/foundation.dart';
import 'package:woocommerce/models/products.dart';

class CartItem {
  final int id;
  final WooProduct product;
  int quantity;

  CartItem({
    @required this.id,
    @required this.product,
    this.quantity = 1,
  });
}

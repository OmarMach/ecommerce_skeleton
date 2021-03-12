import 'package:ecommerce_app/models/cartItem.dart';
import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get items {
    return {..._cartItems};
  }

  int get count {
    return _cartItems.length;
  }

  void addCartItem(String productId, String title, double price) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (value) => CartItem(
          id: value.id,
          title: value.title,
          price: value.price,
          quantity: value.quantity + 1,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }
}

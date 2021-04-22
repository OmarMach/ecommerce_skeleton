import 'package:ecommerce_app/models/cartItem.dart';
import 'package:flutter/foundation.dart';
import 'package:woocommerce/models/products.dart';

class CartProvider with ChangeNotifier {
  Map<int, CartItem> _cartItems = {};

  // Getting an immutable copy of the cart items list.
  Map<int, CartItem> get items {
    return {..._cartItems};
  }

  // Getting the number of different cart items
  int get count {
    return _cartItems.length;
  }

  // Getting the total of the cart items
  double get total {
    double total = 0;
    _cartItems.forEach((key, value) {
      total = total + double.parse(value.product.price) * value.quantity;
    });
    return total;
  }

  // Clearing the cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Deleting a cart item
  void deleteCartItem(CartItem cartItem) {
    try {
      // Deleting an item by their id.
      _cartItems.removeWhere((key, value) => value.id == cartItem.id);
      notifyListeners();
    } catch (e) {
      print("Error while deleting item : " + e);
    }
  }

  void incrementCartItemQuantity(CartItem cartItem) {
    try {
      _cartItems.values
          .firstWhere((element) => element.id == cartItem.id)
          .quantity++;
      notifyListeners();
    } catch (e) {
      print("Error wile incrementing the quantity : " + e);
    }
  }

  void decrementCartItemQuantity(CartItem cartItem) {
    try {
      CartItem item =
          _cartItems.values.firstWhere((element) => element.id == cartItem.id);

      if (item.quantity > 1)
        _cartItems.values
            .firstWhere((element) => element.id == cartItem.id)
            .quantity--;
      else
        deleteCartItem(cartItem);
      notifyListeners();
    } catch (e) {
      print("Error wile incrementing the quantity : " + e);
    }
  }

  void addCartItem(WooProduct product, {int quantity = 1}) {
    try {
      // Adding +1 to the quantity of the product if it exists already
      if (_cartItems.containsKey(product.id)) {
        _cartItems.update(
          product.id,
          (value) => CartItem(
            id: value.id,
            product: value.product,
            quantity: value.quantity + quantity ?? 1,
          ),
        );
      } else {
        // Creating a new entry to the cartitems list
        _cartItems.putIfAbsent(
          product.id,
          () => CartItem(
            id: product.id,
            product: product,
            quantity: quantity ?? 1,
          ),
        );
      }
      // Sending an update message to the UI so it re-renders.
      notifyListeners();
    } catch (e) {
      print("Error while adding the the cart: " + e);
    }
  }
}

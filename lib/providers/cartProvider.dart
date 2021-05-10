import 'package:ecommerce_app/models/cartItem.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/models/products.dart';
import 'package:http/http.dart' as http;
import 'package:woocommerce/woocommerce.dart';
import 'dart:convert';

import '../config.dart';

class CartProvider with ChangeNotifier {
  Map<int, CartItem> _cartItems = {};
  Map<String, String> _compressedCart = {};

  // Getting an immutable copy of the cart items list.
  Map<int, CartItem> get items {
    return {..._cartItems};
  }

  // Getting the total of the cart items
  double get total {
    double total = 0;
    _cartItems.forEach((key, value) {
      total = total + double.parse(value.product.price) * value.quantity;
    });
    return total;
  }

  // Getting the number of different cart items
  int get count {
    return _cartItems.length;
  }

  CartItem getCartItemById(int id) {
    return _cartItems[id] ?? null;
  }

  Future<void> loadCartFromSharedPrefs() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      String encodedCart = _prefs.getString('cart');
      if (encodedCart != null) {
        final Map decodedCart = json.decoder.convert(encodedCart);
        decodedCart.forEach((key, value) {
          _compressedCart[key] = value;
        });
      }
      if (_compressedCart.isNotEmpty) getcartItemsFromDb();
    } catch (e) {
      print("Error while Loading the cart from cache : " + e.toString());
    }
  }

  Future updateSharedPrefs() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String encodedCart = json.encode(_compressedCart);
      await _prefs.setString('cart', encodedCart);
    } catch (e) {
      print(e);
    }
  }

  Future<Map<int, CartItem>> getcartItemsFromDb() async {
    try {
      _cartItems.clear();
      // Adding params
      final Map<String, dynamic> params = {
        'status': 'publish',
        'per_page': _compressedCart.length.toString(),
        'include': _compressedCart.keys.join(','),
      };
      final List productList = [];

      final Uri uri = Uri.https('goods.tn', 'wp-json/wc/v3/products', params);
      final response = await http.get(uri, headers: headers);

      // decoding the results into a list.
      productList.addAll(json.decode(response.body) as List);

      // Converting each item to WooProduct.
      productList.forEach(
        (element) {
          // Converting product from Json to WooProduct.
          final WooProduct product = WooProduct.fromJson(element);

          // Getting the categories
          final List categories = element['categories'];
          final List attributes = element['attributes'];

          attributes.forEach(
            (element) {
              final WooProductItemAttribute productAttribute =
                  WooProductItemAttribute.fromJson(element);
              product.attributes.add(productAttribute);
            },
          );

          // Adding the categories to the product.
          categories.forEach(
            (element) {
              final WooProductCategory category =
                  WooProductCategory.fromJson(element);
              // Avoiding duplicates
              if (product.categories
                      .indexWhere((product) => product.id == category.id) ==
                  -1) product.categories.add(element);
            },
          );

          // Adding the product to the list
          if (!_cartItems.containsKey(product.id))
            _cartItems[product.id] = CartItem(
              id: product.id,
              product: product,
              quantity: int.tryParse(
                _compressedCart[product.id.toString()],
              ),
            );
          notifyListeners();
        },
      );
    } catch (e) {
      print(e);
    }
    return _cartItems;
  }

  Future<void> compressCartItem(int quantity, int id) async {
    try {
      int oldQuantity =
          int.tryParse(_compressedCart[id.toString()] ?? '0') ?? 0;
      int newQuantity = oldQuantity + quantity;
      _compressedCart[id.toString()] = newQuantity.toString();

      if (int.tryParse(_compressedCart[id.toString()]) <= 0)
        _compressedCart.remove(id.toString());

      await updateSharedPrefs();
    } catch (e) {
      print(e);
    }
  }

  // Clearing the cart
  void clearCart() async {
    _cartItems.clear();
    _compressedCart.clear();
    await updateSharedPrefs();
    notifyListeners();
  }

  // Deleting a cart item
  Future<void> deleteCartItem(CartItem cartItem) async {
    try {
      // Deleting an item by their id.
      _cartItems.removeWhere((key, value) => value.id == cartItem.id);
      _compressedCart
          .removeWhere((key, value) => cartItem.id.toString() == key);
      await updateSharedPrefs();
      notifyListeners();
    } catch (e) {
      print("Error while deleting item : " + e);
    }
  }

  Future<void> incrementCartItemQuantity(CartItem cartItem) async {
    try {
      await compressCartItem(1, cartItem.id);
      _cartItems.values
          .firstWhere((element) => element.id == cartItem.id)
          .quantity++;
      notifyListeners();
    } catch (e) {
      print("Error wile incrementing the quantity : " + e);
    }
  }

  Future<void> decrementCartItemQuantity(CartItem cartItem) async {
    try {
      CartItem item =
          _cartItems.values.firstWhere((element) => element.id == cartItem.id);

      if (item.quantity > 1)
        _cartItems.values
            .firstWhere((element) => element.id == cartItem.id)
            .quantity--;
      else
        deleteCartItem(cartItem);

      await compressCartItem(-1, cartItem.id);
      notifyListeners();
    } catch (e) {
      print("Error wile incrementing the quantity : " + e);
    }
  }

  Future<void> addCartItem(WooProduct product, {int quantity = 1}) async {
    try {
      // Adding  to the quantity of the product if it exists already
      if (_cartItems.containsKey(product.id)) {
        _cartItems.update(
          product.id,
          (value) {
            int quantityToAdd;

            // The qte is at it's max, can't add more in the cart.
            if (value.quantity == value.product.stockQuantity)
              return value;
            // the qte and the added qte are > than the stock
            else if ((value.quantity + quantity) > value.product.stockQuantity)
              quantityToAdd = value.product.stockQuantity - value.quantity;
            else
              quantityToAdd = value.quantity + quantity;

            final cartItem = CartItem(
              id: value.id,
              product: value.product,
              quantity: quantityToAdd,
            );
            compressCartItem(quantityToAdd, product.id);
            return cartItem;
          },
        );
      } else {
        // Creating a new entry to the cartitems list
        _cartItems.putIfAbsent(
          product.id,
          () => CartItem(
            id: product.id,
            product: product,
            quantity: quantity > product.stockQuantity
                ? product.stockQuantity
                : quantity ?? 1,
          ),
        );
      }
      compressCartItem(
        quantity > product.stockQuantity
            ? product.stockQuantity
            : quantity ?? 1,
        product.id,
      );
      // Sending an update message to the UI so it re-renders.
      notifyListeners();
    } catch (e) {
      print("Error while adding the the cart: " + e);
    }
  }
}

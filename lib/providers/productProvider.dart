import 'package:ecommerce_app/config.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [
    ...dummyList,
  ];

  bool showFavoritesOnly = false;

  List<Product> get items {
    if (showFavoritesOnly)
      return _products.where((element) => element.isFavorite).toList();
    return [..._products];
  }

  // ignore: missing_return
  Product getProductById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }

  void toggleFavoriteList() {
    showFavoritesOnly = !showFavoritesOnly;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:woocommerce/models/products.dart';

class FavoritesProvider with ChangeNotifier {
  final List<WooProduct> favorites = [];

  bool addToFavorites(WooProduct product) {
    if (!favorites.contains(product)) {
      favorites.add(product);
      notifyListeners();
      return true;
    }
    return false;
  }

  bool deleteFromFavorites(WooProduct product) {
    if (!favorites.contains(product)) {
      favorites.remove(product);
      notifyListeners();
      return true;
    }
    return false;
  }

  void clearFavorites() {
    favorites.clear();
  }
}

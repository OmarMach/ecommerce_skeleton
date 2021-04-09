import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:woocommerce/models/products.dart';

class FavoritesProvider with ChangeNotifier {
  List<WooProduct> _favorites = [];

  List<WooProduct> get favorites {
    return [..._favorites];
  }

  // Returns true if the product is already in the wish list
  bool checkIfAlreadyExists(WooProduct product) {
    return _favorites.where((elem) => elem.id == product.id).isNotEmpty;
  }

  bool addToFavorites(WooProduct product) {
    // If the product doesn't exist
    if (!checkIfAlreadyExists(product)) {
      _favorites.add(product);
      notifyListeners();
      print("Product added to favs");
      return true;
    }
    return false;
  }

  void deleteFromFavorites(WooProduct product) {
    _favorites.removeWhere((elem) => elem.id == product.id);
    print("Product deleted from favs");
    notifyListeners();
  }

  void sortFavoritesByPrice(String order) {
    if (order == 'ASC')
      _favorites.sort(
        (a, b) => int.parse(
          (double.parse(a.price) - double.parse(b.price)).toString(),
        ),
      );
    else
      _favorites.sort(
        (a, b) => int.parse(
          (double.parse(b.price) - double.parse(a.price)).toString(),
        ),
      );
    notifyListeners();
  }

  void sortFavoritesByName(String order) {
    if (order == 'ASC')
      _favorites.sort(
        (a, b) => a.name.toLowerCase().compareTo(
              b.name.toLowerCase(),
            ),
      );
    else
      _favorites.sort(
        (b, a) => a.name.toLowerCase().compareTo(
              b.name.toLowerCase(),
            ),
      );
    notifyListeners();
  }

  void clearFavorites() {
    _favorites.clear();
  }
}

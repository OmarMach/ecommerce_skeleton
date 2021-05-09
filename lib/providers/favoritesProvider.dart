import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/models/products.dart';
import 'package:http/http.dart' as http;
import 'package:woocommerce/woocommerce.dart';

import '../config.dart';

class FavoritesProvider with ChangeNotifier {
  final List<WooProduct> _favorites = [];
  final List<String> _favsIdList = [];

  List<WooProduct> get favorites {
    return [..._favorites];
  }

  Future loadFavoritesFromSharedPrefs() async {
    _favorites.clear();
    _favsIdList.clear();

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final List<String> loadedFavs = _prefs.getStringList('favorites');
    _favsIdList.addAll(loadedFavs);

    // Getting the product information from the database
    if (loadedFavs.isNotEmpty) await getFavoritesFromDb();
  }

  Future addFavoritesToSharedPrefs(int id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _favsIdList.add(id.toString());

    await _prefs.setStringList('favorites', _favsIdList);
  }

  Future deleteFavFromSharedPrefs(int id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _favsIdList.removeWhere((elem) => elem == id.toString());

    await _prefs.setStringList('favorites', _favsIdList);
  }

  // Returns true if the product is already in the wish list
  bool checkIfAlreadyExists(WooProduct product) {
    return _favorites.where((elem) => elem.id == product.id).isNotEmpty;
  }

  Future<bool> addToFavorites(WooProduct product) async {
    // If the product doesn't exist
    if (!checkIfAlreadyExists(product)) {
      _favorites.add(product);
      _favsIdList.add(product.id.toString());
      await addFavoritesToSharedPrefs(product.id);
      notifyListeners();
      return true;
    }
    return false;
  }

  void deleteFromFavorites(WooProduct product) {
    _favorites.removeWhere((elem) => elem.id == product.id);
    deleteFavFromSharedPrefs(product.id);
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
    notifyListeners();
  }

  Future<List<WooProduct>> getFavoritesFromDb() async {
    _favorites.clear();
    // Adding params
    final Map<String, dynamic> params = {
      'status': 'publish',
      'per_page': _favsIdList.length.toString(),
      'include': _favsIdList.join(','),
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
        if (!_favorites.contains(product)) _favorites.add(product);
        notifyListeners();
      },
    );
    return _favorites;
  }
}

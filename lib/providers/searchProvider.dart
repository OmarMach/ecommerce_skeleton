import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class SearchProvider with ChangeNotifier {
  final List<WooProductCategory> selectedFilters = [];
  final List<WooProduct> searchedProducts = [];
  bool isLoading = false;
  String sortValue;

  void clearFilters() {
    selectedFilters.clear();
    searchedProducts.clear();
    notifyListeners();
  }

  void toggleLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void clearSearchedProducts() {
    searchedProducts.clear();
    notifyListeners();
  }

  Future addFilter(WooProductCategory category) async {
    selectedFilters.add(category);
    notifyListeners();
  }

  void removeFilter(WooProductCategory category) {
    selectedFilters.remove(category);
    removeSearchedItemsByCategory(category.id);
    notifyListeners();
  }

  void removeSearchedItemsByCategory(int id) {
    searchedProducts.removeWhere((prod) {
      return prod.categories.where((cat) {
        if (cat.id == id || cat.parent == id) {
          print("Deleting Product : ${prod.name} : ${cat.id}");
          return true;
        } else
          return false;
      }).isNotEmpty;
    });
    notifyListeners();
  }

  void addAll(List<WooProductCategory> categories) {
    selectedFilters.addAll(categories);
    notifyListeners();
  }

  Future searchProductByCategoriesId(List<int> categoriesId) async {
    isLoading = true;
    notifyListeners();

    categoriesId.forEach(
      (element) async {
        await searchProductsByCategory(element);
      },
    );

    isLoading = false;
    notifyListeners();
  }

  void sortSearchedProducts(String sortMethod) {
    sortValue = sortMethod;
    switch (sortValue) {
      case 'Sort By Popularity':
        searchedProducts.sort(
          (WooProduct a, WooProduct b) => a.totalSales.compareTo(b.totalSales),
        );
        break;
      case 'Sort By Latest':
        searchedProducts.sort(
          (WooProduct a, WooProduct b) => a.id.compareTo(b.id),
        );
        break;
      case 'Sort By Title: A to Z':
        searchedProducts.sort(
          (WooProduct a, WooProduct b) => a.name.toLowerCase().compareTo(
                b.name.toLowerCase(),
              ),
        );
        break;
      case 'Sort By Title: Z to A':
        searchedProducts.sort(
          (WooProduct a, WooProduct b) => b.name.toLowerCase().compareTo(
                a.name.toLowerCase(),
              ),
        );
        break;
      case 'Sort By Price: Low to High':
        searchedProducts.sort(
          (WooProduct a, WooProduct b) => a.price.toLowerCase().compareTo(
                b.price.toLowerCase(),
              ),
        );
        break;
      case 'Sort By Price: High to Low':
        searchedProducts.sort(
          (WooProduct a, WooProduct b) => b.price.toLowerCase().compareTo(
                a.price.toLowerCase(),
              ),
        );
        break;
    }
    notifyListeners();
  }

  Future searchProductsByCategory(int categoryId) async {
    // Clearing the searched products.
    searchedProducts.clear();

    // Setting the state to loading
    // toggleLoadingState();

    // Setting the params to send into the request
    final Map<String, dynamic> params = {
      'per_page': '100',
      'status': 'publish',
    };

    // search by category
    if (categoryId != 0) params['category'] = categoryId.toString();

    final Uri uri = Uri.https('goods.tn', 'wp-json/wc/v3/products', params);
    final response = await http.get(uri, headers: headers);

    // decoding the results into a list.
    final List productList = json.decode(response.body) as List;

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
        if (!searchedProducts.contains(product)) searchedProducts.add(product);
      },
    );
    // Setting the state to loading
    toggleLoadingState();
  }

  Future<List<WooProduct>> searchProductByKeyword(String keyword) async {
    print("Searching keyword : " + keyword);
    searchedProducts.clear();
    // Adding params
    final Map<String, dynamic> params = {
      'per_page': '100',
      'status': 'publish',
      'search': keyword ?? ' ',
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
        if (!searchedProducts.contains(product)) searchedProducts.add(product);
        notifyListeners();
      },
    );
    return searchedProducts;
  }
}

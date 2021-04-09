import 'dart:convert';

import 'package:ecommerce_app/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:woocommerce/models/products.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  final List<WooProduct> _products = [];

  List<WooProduct> get items {
    return _products;
  }

  final List<WooProduct> filteredProducts = [];

  WooProduct getProductById(int id) {
    print("Getting Product with Id : $id");

    return _products.firstWhere(
      (element) => element.id == id,
    );
  }

  List<WooProduct> searchProductsByName(String name) {
    // Returns a list of products that aren't duplicates in the filtered lists and have the given name.
    return _products.where(
      (element) =>
          !filteredProducts.contains(element) && element.name.contains(name),
    );
  }

  List<WooProduct> searchProductsByFilters({
    String name = '',
    List<int> categoryIds,
  }) {
    print(categoryIds.length);
    // initializing an empty list to return it back
    final List<WooProduct> searchedProducts = [];

    // clearing the filtered global list.
    filteredProducts.clear();

    // If the categoryids list isn't null and contians elements the function will be executed.
    if (categoryIds != null && categoryIds.isNotEmpty)
      searchedProducts.addAll(searchProductsByCategories(categoryIds));

    // if the name isn't null and not empty send the request
    if (name != null && name.isNotEmpty)
      searchedProducts.addAll(searchProductsByName(name));

    // notify the widget tree to rebuild.
    // notifyListeners();

    return searchedProducts;
  }

  List<WooProduct> searchProductsByCategories(List<int> categoryIds) {
    final List<WooProduct> products = [];

    categoryIds.forEach(
      (categoryId) {
        _products.forEach(
          (element) {
            if (element.categories.where((element) {
              return element.parent == categoryId;
            }).isNotEmpty) {
              products.add(element);
              if (!filteredProducts.contains(element))
                filteredProducts.add(element);
            }
          },
        );
      },
    );
    notifyListeners();
    return products;
  }

  List<WooProduct> getProductsByCategory(int categoryId) {
    final List<WooProduct> products = [];
    _products.forEach((element) {
      if (element.categories
          .where((element) => element.id == categoryId)
          .isNotEmpty) products.add(element);
    });
    return products;
  }

  Future<List<WooProduct>> getProductsFromDb(BuildContext context) async {
    // Clearing the entries
    _products.clear();

    // Adding params
    final Map<String, dynamic> params = {
      'per_page': '100',
      'page': '1',
      'status': 'publish',
    };

    try {
      // Creating the URL
      final Uri uri = Uri.https('goods.tn', 'wp-json/wc/v3/products', params);

      // Sending the request
      // final response = await http.get(uri, headers: headers);
      final String response = await DefaultAssetBundle.of(context)
          .loadString("assets/responseExample.json");

      // decoding the results into a list.
      final List productList = json.decode(response) as List;

      // Converting each item to WooProduct.
      productList.forEach((element) {
        // Converting product from Json to WooProduct.
        final WooProduct product = WooProduct.fromJson(element);

        // Getting the categories
        final List categories = element['categories'];
        final List attributes = element['attributes'];

        attributes.forEach((element) {
          final WooProductItemAttribute productAttribute =
              WooProductItemAttribute.fromJson(element);
          product.attributes.add(productAttribute);
        });

        // Adding the categories to the product.
        categories.forEach((element) {
          final WooProductCategory category =
              WooProductCategory.fromJson(element);
          // Avoiding duplicates
          if (product.categories
                  .indexWhere((product) => product.id == category.id) ==
              -1) product.categories.add(element);
        });

        // Adding the product to the list
        _products.add(product);
      });
    } catch (e) {
      print("Error : " + e.toString());
    }
    return items;
  }
}

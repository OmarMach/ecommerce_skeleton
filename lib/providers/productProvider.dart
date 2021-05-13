import 'dart:convert';

import 'package:ecommerce_app/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:woocommerce/models/products.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  final List<WooProduct> _products = [];
  final List<WooProduct> _carouselProducts = [];

  List<WooProduct> get items {
    return _products;
  }

  List<WooProduct> get carouselItems {
    return _carouselProducts;
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

  void searchProductsByFilters({
    String name = '',
    List<int> categoriesId,
  }) {
    // clearing the filtered global list.
    filteredProducts.clear();

    // If the categoriesId list isn't null and contians elements the function will be executed.
    if (categoriesId != null && categoriesId.isNotEmpty)
      filteredProducts.addAll(searchProductsByCategories(categoriesId));

    // if the name isn't null and not empty send the request
    if (name != null && name.isNotEmpty)
      filteredProducts.addAll(
        searchProductsByName(name),
      );

    print("Filtered products count : " + filteredProducts.length.toString());
  }

  List<WooProduct> searchProductsByCategories(List<int> categoriesId) {
    final List<WooProduct> searchedProducts = [];
    categoriesId.forEach(
      (categoryId) {
        _products.forEach(
          (element) {
            bool belongsToCategory = element.categories
                .where((element) => categoryId == element.id)
                .isNotEmpty;
            if (belongsToCategory && !searchedProducts.contains(element))
              searchedProducts.add(element);
          },
        );
      },
    );

    return searchedProducts;
  }

  Future<List<WooProduct>> getProductsByCategory(int categoryId) async {
    // Adding params
    final Map<String, dynamic> params = {
      'per_page': '100',
      'status': 'publish',
      'category': '$categoryId',
    };
    final List productList = [];
    final List<WooProduct> searchedProducts = [];

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
      },
    );
    return searchedProducts;
  }

  Future<List<WooProduct>> getCarouselProducts() async {
    // Adding params
    final Map<String, dynamic> params = {
      'per_page': '100',
      'status': 'publish',
      'featured': 'true',
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
        if (!_carouselProducts.contains(product))
          _carouselProducts.add(product);
      },
    );
    return _carouselProducts;
  }

  Future<List<WooProduct>> getProductsFromDb(BuildContext context,
      {int limit = 0}) async {
    // Pagination variable
    int pageNumber = 0;

    // Clearing the entries
    _products.clear();

    // Adding params
    final Map<String, dynamic> params = {
      'per_page': limit > 0 ? limit.toString() : '10',
      'page': pageNumber.toString(),
      'status': 'publish',
    };
    final List productList = [];

    try {
      // do {
      // emptying the product List to not get into a infinite loop.
      productList.clear();

      // Incrementing the page
      pageNumber++;
      params['page'] = pageNumber.toString();
      print(params);

      // Creating the URL
      final Uri uri = Uri.https('goods.tn', 'wp-json/wc/v3/products', params);

      // Sending the request
      final response = await http.get(uri, headers: headers);
      // final String response = await DefaultAssetBundle.of(context)
      // .loadString("assets/responseExample.json");

      // decoding the results into a list.
      productList.addAll(json.decode(response.body) as List);

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
      print("Total products retrieved : " + _products.length.toString());
      // } while (productList.isNotEmpty);
    } catch (e) {
      print("Error : " + e.toString());
    }
    return items;
  }
}

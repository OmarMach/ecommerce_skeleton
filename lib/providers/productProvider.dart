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

  WooProduct getProductById(int id) {
    print("Getting Product with Id : $id");

    return _products.firstWhere(
      (element) => element.id == id,
    );
  }

  Future<List<WooProduct>> getProductsFromDb() async {
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
      final response = await http.get(uri, headers: headers);

      // decoding the results into a list.
      final List productList = json.decode(response.body) as List;

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
          print(productAttribute);
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

import 'dart:convert';

import 'package:ecommerce_app/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  WooCommerce endpoint = WooCommerce(
    baseUrl: baseUrl,
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
    // isDebug: true,
  );

  final List<WooProduct> _products = [];

  DateTime lastRefresh = DateTime.now();

  bool showFavoritesOnly = false;

  List<WooProduct> get items {
    return _products;
  }

  // ignore: missing_return
  WooProduct getProductById(int id) {
    print("Getting Product By Id");
    return _products.firstWhere(
      (element) => element.id == id,
    );
  }

  Future<List<WooProduct>> getProductsFromDb() async {
    _products.clear();

    // Encoding the auth informations
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$consumerKey:$consumerSecret'));

    // Adding headers
    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': basicAuth,
    };

    // Adding params
    final Map<String, dynamic> params = {
      'per_page': 100.toString(),
      'page': '1',
      'status': 'publish',
      'featured': 'true',
    };

    try {
      // Creating the URL
      final Uri uri = Uri.https('goods.tn', 'wp-json/wc/v3/products', params);

      // Sending the request
      final response = await http.get(
        uri,
        headers: headers,
      );

      // decoding the results into a list.
      final List productList = json.decode(response.body) as List;

      // Converting each item to product.
      productList.forEach((element) {
        final WooProduct product = WooProduct.fromJson(element);
        // Getting the categories
        final List categories = element['categories'];
        // Adding the categories to the product.
        categories.forEach((element) {
          print(element);
          print(product.categories);
          final WooProductCategory category =
              WooProductCategory.fromJson(element);
          product.categories.add(category);
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

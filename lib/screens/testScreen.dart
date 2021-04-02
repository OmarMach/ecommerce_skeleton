import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:woocommerce/models/products.dart';

import '../config.dart';

class TestScreen extends StatefulWidget {
  static const routeName = '/test';
  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends State<TestScreen> {
  bool isLoading = false;
  Future<void> checkDatabaseConnection() async {
    setState(() {
      isLoading = true;
    });

    try {
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$consumerKey:$consumerSecret'));

      Map<String, String> headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': basicAuth,
      };

      final Map<String, dynamic> params = {
        'per_page': 100.toString(),
        'page': '1',
        'status': 'publish',
        'featured': 'true',
      };

      final Uri uri = Uri.https('goods.tn', 'wp-json/wc/v3/products', params);
      final response = await http.get(
        uri,
        headers: headers,
      );
      final List productList = json.decode(response.body) as List;
      productList.forEach((element) {
        final WooProduct product = WooProduct.fromJson(element);
      });
    } catch (e) {
      print("Error : " + e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: checkDatabaseConnection,
          child: isLoading
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
              : Text("Test DB Connection"),
        ),
      ),
    );
  }
}

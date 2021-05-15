import 'dart:convert';

import 'package:ecommerce_app/models/address.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/models/products.dart';

import '../config.dart';

class UserProvider with ChangeNotifier {
  User _user;
  String _token;
  Address _address;

  User get user {
    return _user;
  }

  Address get userAddress {
    return _address;
  }

  bool get isConnected {
    if (_token == null) return false;
    return _token.isEmpty ? false : true;
  }

  Future initUserStatus() async {
    _token = '';
    await loadAddressFromSharedPrefs();
    await loadUserFromSharedPrefs();
  }

  Future loadUserFromSharedPrefs() async {}

  Future<void> createAddress(Map map) async {
    try {
      _address = Address.fromJSON(map);
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      String encodedAddress = json.encode(_address);

      await _prefs.setString('address', encodedAddress);
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadAddressFromSharedPrefs() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String encodedAddress = _prefs.getString("address");

      if (encodedAddress != null)
        _address = Address.fromJSON(
          json.decode(encodedAddress),
        );

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future registerUser(String email) async {
    // Adding params
    final Map<String, dynamic> params = {
      'per_page': '100',
      'page': '1',
      'status': 'publish',
    };

    // Creating the URL
    final Uri uri = Uri.https('goods.tn', '/wp-json/wc/v3/customers', params);

    // Sending the request
    final response = await http.get(uri, headers: headers);
  }

  Future login(String userName, String password) async {
    // Adding params
    final Map<String, dynamic> params = {
      'per_page': '100',
      'page': '1',
      'status': 'publish',
    };

    // Creating the URL
    final Uri uri = Uri.https('goods.tn', '/wp-json/wc/v3/customers', params);

    // Sending the request
    final response = await http.get(uri, headers: headers);
    return false;
  }

  Future createOrder({Address address, List<WooProduct> products}) async {
    // Adding params
    final Map<String, dynamic> params = {
      'per_page': '100',
      'page': '1',
      'status': 'publish',
    };

    // Creating the URL
    final Uri uri = Uri.https('goods.tn', '/wp-json/wc/v3/orders', params);

    // Sending the request
    final response = await http.post(
      uri,
      headers: headers,
      body: {},
    );

    return false;
  }
}

import 'dart:async';
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

  Future loadUserFromSharedPrefs() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _token = _prefs.getString('token') ?? '';
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future saveUserToSharedPrefs(String cookie) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      await _prefs.setString('token', cookie);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

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

  Future<bool> registerUser(String email, String password) async {
    // Adding params
    final Map<String, dynamic> params = {
      'rest_route': '/simple-jwt-login/v1/users',
      'email': 'omramch@fmak.cmo',
      'password': '$password',
      'test-auth-key': 'test-auth-key',
    };
    
    try {
      // Creating the URL
      final Uri uri = Uri.https('goods.tn', '', params);

      // Sending the request
      final response = await http.post(uri, headers: headers).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Please verify your internet connection.');
        },
      );

      final decodedBody = json.decode(response.body) as Map;

      if (decodedBody['success'] == 'true') {
        await login(email: email, password: password);
        return true;
      } else
        throw ("error");
    } on TimeoutException catch (_) {
      throw ('Please verify your internet connection');
    } catch (e) {
      throw ('You can\'t use this email address.');
    }
  }

  Future login(
      {@required String password, String email, String username}) async {
    // Adding params
    final Map<String, dynamic> params = {
      'password': password,
    };

    try {
      if (email != null) params['email'] = email;
      if (username != null) params['username'] = username;

      // Creating the URL
      final Uri uri =
          Uri.https('goods.tn', '/api/user/generate_auth_cookie/', params);

      // Sending the request
      final response = await http.get(uri, headers: headers).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Please verify your internet connection.');
        },
      );
      final decodedBody = json.decode(response.body) as Map;

      if (decodedBody['status'].toString() == 'ok') {
        _token = decodedBody['cookie'] as String;
        _user = User.fromJson(decodedBody['user'] as Map);
      } else
        throw (decodedBody['error']);
    } on TimeoutException catch (_) {
      throw ('Please verify your internet connection');
    } catch (e) {
      print("Error while logging : $e");
      throw ('Please verify your credentials.');
    }
  }

  void logout() {
    _token = '';
    notifyListeners();
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

import 'dart:async';
import 'dart:convert';

import 'package:ecommerce_app/models/address.dart';
import 'package:ecommerce_app/models/cartItem.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class UserProvider with ChangeNotifier {
  User _user;
  String _token;
  Address _address;
  List<Order> _userOrders = [];

  List<Order> get userOrders {
    return _userOrders;
  }

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
    await loadUserFromSharedPrefs();
    await getUserOrders();
    await loadAddressFromSharedPrefs();
  }

  Future loadUserFromSharedPrefs() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _token = _prefs.getString('token') ?? '';
      await getUserInformation();

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

      await _prefs.setString('address', _address.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadAddressFromSharedPrefs() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String encodedAddress = _prefs.getString("address");

      if (encodedAddress != null) {
        _address = Address.fromJSON(
          json.decode(encodedAddress),
        );
      }

      notifyListeners();
    } catch (e) {
      print("Error while getting address from shared prefs :\n$e");
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
        notifyListeners();
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
        saveUserToSharedPrefs(_token);
        await initUserStatus();
      } else
        throw (decodedBody['error']);
    } on TimeoutException catch (_) {
      throw ('Please verify your internet connection.');
    } catch (e) {
      print("Error while logging : $e");
      throw ('Please verify your credentials.');
    }
    notifyListeners();
  }

  Future getUserInformation() async {
    // Adding params
    final Map<String, dynamic> params = {
      'cookie': '$_token',
    };

    try {
      // Creating the URL
      final Uri uri = Uri.https(
        'goods.tn',
        '/api/user/get_currentuserinfo/',
        params,
      );

      // Sending the request
      final response = await http.get(uri, headers: headers).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Please verify your internet connection.');
        },
      );

      final decodedBody = json.decode(response.body) as Map;

      if (decodedBody['status'].toString() == 'ok') {
        _user = User.fromJson(decodedBody['user'] as Map);
        saveUserToSharedPrefs(_token);
      } else {
        logout();
      }
    } on TimeoutException catch (_) {
      throw ('Please verify your internet connection');
    } catch (e) {
      print("Error while logging : $e");
      throw ('Please verify your credentials.');
    }
    notifyListeners();
  }

  void logout() {
    _token = '';
    notifyListeners();
  }

  Future<bool> createOrder({
    @required Map address,
    @required Map<int, CartItem> cartItems,
    Map deliveryRates,
  }) async {
    try {
      // Creating the URL
      final Uri uri = Uri.https('goods.tn', '/wp-json/wc/v3/orders/');

      final transformedCart = [];
      cartItems.forEach(
        (k, v) => transformedCart.add(
          {
            'product_id': '$k',
            'quantity': '${v.quantity}',
          },
        ),
      );

      // Sending the request
      final response = await http.post(
        uri,
        headers: headers,
        body: json.encode(
          {
            'customer_id': _user.id,
            'billing': address,
            'shipping': address,
            'line_items': transformedCart,
            'shipping_lines': [deliveryRates],
          },
        ),
      );

      final data = json.decode(response.body);
      print(data);
      return data['id'] != null;
    } catch (e) {
      print("error : " + e.toString());
      return false;
    }
  }

  Future<List<Order>> getUserOrders() async {
    _userOrders.clear();

    // Adding params
    final Map<String, dynamic> params = {
      'customer': '${user.id}',
    };

    try {
      // Creating the URL
      final Uri uri = Uri.https('goods.tn', '/wp-json/wc/v3/orders', params);

      // Sending the request
      final response = await http.get(
        uri,
        headers: headers,
      );

      final ordersList = json.decode(response.body) as List;

      if (ordersList.isNotEmpty) {
        ordersList.forEach((element) {
          final Order order = Order.fromJSON(element);
          _userOrders.add(order);
        });
      }
      return _userOrders;
    } catch (e) {
      throw (e);
    }
  }
}

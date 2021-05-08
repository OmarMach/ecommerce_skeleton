import 'package:ecommerce_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class UserProvider with ChangeNotifier {
  User _user;
  String _token;

  bool get isConnected {
    if (_token == null) return false;
    return _token.isEmpty ? false : true;
  }

  Future initUserStatus() async {
    _token = '';
    await getUserDataFromSharedPrefs();
  }

  Future getUserDataFromSharedPrefs() async {}

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
}

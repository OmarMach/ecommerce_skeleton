import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:woocommerce/woocommerce.dart';

import '../config.dart';

class UserProvider with ChangeNotifier {
  String userName;
  String email;
  Future<void> login(String userName, String password) async {
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
}

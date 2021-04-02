import 'dart:convert';

const baseUrl = "https://goods.tn/";

// Auth informations
const consumerKey = "ck_553867198d1018a037183c1da7ee85bcd2955c3e";
const consumerSecret = "cs_873fe51026c07463bd0d6d4ab4f8b63bd98f5c35";

final String basicAuth =
    'Basic ' + base64Encode(utf8.encode('$consumerKey:$consumerSecret'));

// Requrest Headers
final Map<String, String> headers = {
  'content-type': 'application/json',
  'accept': 'application/json',
  'authorization': basicAuth,
};

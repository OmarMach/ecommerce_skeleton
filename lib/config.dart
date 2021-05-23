import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

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
const Color googleColor = Color(0xFFDB4437);
const Color facebookColor = Color(0xFF4267B2);

final redBox = Flexible(
  child: FittedBox(
    fit: BoxFit.fitWidth,
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: 10,
        height: 20,
        color: Colors.redAccent,
      ),
    ),
  ),
);

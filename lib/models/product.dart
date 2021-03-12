import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String title;
  final String imageURl;
  final String description;
  final double price;
  final bool isInStock;

  Product({
    @required this.id,
    @required this.imageURl,
    @required this.title,
    @required this.description,
    @required this.price,
    this.isInStock = true,
  });
}

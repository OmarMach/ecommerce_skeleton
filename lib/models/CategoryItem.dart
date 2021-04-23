import 'package:flutter/foundation.dart';
import 'package:woocommerce/models/product_category.dart';

class CategoryItem {
  final String name;
  final WooProductCategory category;
  final List<WooProductCategory> subCategories = [];

  CategoryItem({
    @required this.name,
    @required this.category,
  });
}

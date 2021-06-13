import 'dart:convert';

import 'package:ecommerce_app/models/CategoryItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class CategoriesProvider with ChangeNotifier {
  final Map<String, List<WooProductCategory>> _categories = {
    'categories': [],
    'sub-categories': [],
  };
  final List<WooProductCategory> _grouppedCategories = [];

  final List<CategoryItem> _transformedCategories = [];

  List<CategoryItem> get transformedCategories {
    return [..._transformedCategories];
  }

  List<WooProductCategory> get grouppedCategories {
    return [..._grouppedCategories];
  }

  Map<String, List<WooProductCategory>> get categories {
    return {..._categories};
  }

  List<CategoryItem> transformCategories() {
    // Clearing the list before re transforming it.
    _transformedCategories.clear();

    // Creating the transformed categories
    _categories['categories'].forEach(
      (element) {
        _transformedCategories.add(
          CategoryItem(
            name: element.name,
            category: element,
          ),
        );
      },
    );

    // This will add each sub category to it's parent by ID
    _categories['sub-categories'].forEach(
      (subCat) {
        final category = _transformedCategories.firstWhere(
          (cat) => subCat.parent == cat.category.id,
          orElse: () {
            // returning null if there are no parents for this category.
            // which is very unlekely to happen since sub-categories are put in the subCat list only if their parents != null
            return null;
          },
        );
        if (category != null) category.subCategories.add(subCat);
      },
    );
    return _transformedCategories;
  }

  List<WooProductCategory> getCategoriesByParentId(int id) {
    final List<WooProductCategory> subCategories = [];

    _categories['sub-categories'].forEach((element) {
      if (element.parent == id) subCategories.add(element);
    });

    return subCategories;
  }

  Future<Map<String, List<WooProductCategory>>> getAllCategories() async {
    // Clearing the categories to avoid duplicates.
    _categories['categories'].clear();
    _categories['sub-categories'].clear();
    _grouppedCategories.clear();

    // Adding params
    final Map<String, dynamic> params = {
      'per_page': '100',
      'page': '1',
    };

    try {
      // Creating the URL
      final Uri uri =
          Uri.https('goods.tn', '/wp-json/wc/v3/products/categories', params);
      // Sending the request
      final response = await http.get(uri, headers: headers);

      // Local testing categoreis
      // final String response = await DefaultAssetBundle.of(context)
      // .loadString("assets/CategoryExample.json");
      print("Adding Categories..");

      // decoding the results into a list.
      final List categoriesList = json.decode(response.body) as List;

      categoriesList.forEach((element) {
        // Creating the category item
        final WooProductCategory category =
            WooProductCategory.fromJson(element);

        if (!_grouppedCategories.contains(category))
          _grouppedCategories.add(category);

        // Dividing categories and subcategories.
        if (category.parent == 0)
          _categories['categories'].add(category);
        else
          _categories['sub-categories'].add(category);
      });
    } catch (e) {
      print("Error while Loading categories :" + e.toString());
    }
    notifyListeners();
    return _categories;
  }

  WooProductCategory getCategoryById(int id) {
    WooProductCategory category;
    // Searching the sub-categories list since it's more likely to contain more items than categories.
    category =
        _categories['sub-categories'].firstWhere((element) => element.id == id,
            // if category searched isn't found in the sub-categories.
            orElse: () {
      return _categories['sub-categories']
          .firstWhere((element) => element.id == id);
    });
    return category;
  }

  List<WooProductCategory> getAllOnlyCategories() {
    return _categories['categories'];
  }

  List<WooProductCategory> getAllOnlySubCategories() {
    return _categories['sub-categories'];
  }
}

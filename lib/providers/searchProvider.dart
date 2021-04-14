import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:woocommerce/woocommerce.dart';

class SearchProvider with ChangeNotifier {
  final List<WooProductCategory> selectedFilters = [];
  final List<WooProduct> searchResults;

  SearchProvider({this.searchResults});

  void clearFilters() {
    selectedFilters.clear();
    notifyListeners();
  }

  void addFilter(WooProductCategory category) {
    selectedFilters.add(category);
    notifyListeners();
  }

  void removeFilter(WooProductCategory category) {
    selectedFilters.remove(category);
    notifyListeners();
  }

  void addAll(List<WooProductCategory> categories) {
    selectedFilters.addAll(categories);
    notifyListeners();
  }
}

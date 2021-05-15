import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'providers/categoriesProvider.dart';

Future loadData(BuildContext context) async {
  print("Loading initial Data");
  final categoriesProvider = Provider.of<CategoriesProvider>(context);
  final productsProvider = Provider.of<ProductProvider>(context);

  final loadedcat = await categoriesProvider.getAllCategories(context);
  final loadedprod = await productsProvider.getProductsFromDb();
}

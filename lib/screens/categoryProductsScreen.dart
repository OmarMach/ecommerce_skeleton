import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:ecommerce_app/widgets/productsByCategoryGrid.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class CategoryProductsScreen extends StatefulWidget {
  static const routeName = '/categoryProds';
  @override
  CategoryProductsScreenState createState() => CategoryProductsScreenState();
}

class CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final category =
        ModalRoute.of(context).settings.arguments as Map<String, int>;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerMenuWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  category.keys.first ?? '',
                  textAlign: TextAlign.center,
                  style: textTheme.headline5,
                ),
              ),
              verticalSeparator,
              ProductsByCategoryGridList(
                categoryId: category.values.first,
                limit: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

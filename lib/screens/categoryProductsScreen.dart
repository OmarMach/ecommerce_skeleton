import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';

class CategoryProductsScreen extends StatefulWidget {
  static const routeName = '/categoryProds';
  @override
  CategoryProductsScreenState createState() => CategoryProductsScreenState();
}

class CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(category ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}

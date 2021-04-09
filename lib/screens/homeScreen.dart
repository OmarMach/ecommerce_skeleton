import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/screens/cartScreen.dart';
import 'package:ecommerce_app/screens/searchScreen.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/badge.dart';
import 'package:ecommerce_app/widgets/carouselWidget.dart';
import 'package:ecommerce_app/widgets/productsByCategoryGrid.dart';
import 'package:ecommerce_app/widgets/productsGridList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Hot items",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              verticalSeparator,
              CarouselWidget(),
              verticalSeparator,
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "New Arrivals",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              ProductsGridList(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Screen Refurbish Tools",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductsByCategoryGridList(
                  categoryId: 71,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Soldering accessories",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductsByCategoryGridList(
                  categoryId: 79,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

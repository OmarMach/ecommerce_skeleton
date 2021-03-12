import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/widgets/badge.dart';
import 'package:ecommerce_app/widgets/productWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, products, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Skeleton Application"),
          actions: [
            IconButton(
              icon: Icon(
                showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () {
                setState(() {
                  showFavoritesOnly = !showFavoritesOnly;
                });
              },
            ),
            Consumer<CartProvider>(
              builder: (context, cart, child) => Badge(
                child: child,
                value: cart.count.toString(),
              ),
              child: Icon(Icons.shop),
            )
          ],
        ),
        body: SafeArea(
          child: GridView.builder(
            itemCount: showFavoritesOnly
                ? products.favorites.length
                : products.items.length,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3 / 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return ProductWidget(
                product: showFavoritesOnly
                    ? products.favorites[index]
                    : products.items[index],
              );
            },
          ),
        ),
      );
    });
  }
}

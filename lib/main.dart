import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/categoriesProvider.dart';
import 'package:ecommerce_app/providers/favoritesProvider.dart';
import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/providers/searchProvider.dart';
import 'package:ecommerce_app/routes.dart';
import 'package:ecommerce_app/screens/splashScreen.dart';
import 'package:ecommerce_app/screens/wrapperScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),       
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Goods.tn',
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'ProductSans',
          primaryColor: Colors.grey,
          accentColor: Colors.redAccent,
        ),
        routes: routes,

        // Getting all the products and categories from the database.
        // displaying slpash screen while the data is loading.
        home: Consumer2<ProductProvider, CategoriesProvider>(
          builder: (context, productProvider, categoriesProvider, child) =>
              FutureBuilder(
            future: productProvider.getProductsFromDb(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return SplashScreen();
              else
                return FutureBuilder(
                  future: categoriesProvider.getAllCategories(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return SplashScreen();
                    else
                      return WrapperScreen();
                  },
                );
            },
          ),
        ),
      ),
    );
  }
}

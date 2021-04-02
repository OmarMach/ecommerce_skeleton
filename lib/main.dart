import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/routes.dart';
import 'package:ecommerce_app/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Goods.tn',
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'ProductSans',
        ),
        routes: routes,

        // Getting all the products from the database.
        // displaying slpash screen while the data is loading.
        home: Consumer<ProductProvider>(
          builder: (context, value, child) => FutureBuilder(
            future: value.getProductsFromDb(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return SplashScreen();
              else
                return HomeScreen();
            },
          ),
        ),
      ),
    );
  }
}

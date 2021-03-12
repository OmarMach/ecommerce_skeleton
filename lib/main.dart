import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/screens/productScreen.dart';
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
        title: 'Ecommerce',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        routes: {
          ProductScreen.routeName: (context) => ProductScreen(),
        },
        home: HomeScreen(),
      ),
    );
  }
}

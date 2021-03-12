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
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        title: 'Ecommerce',
        theme: ThemeData(
          primarySwatch: Colors.green,
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

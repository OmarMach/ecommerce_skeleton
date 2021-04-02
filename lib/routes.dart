import 'package:ecommerce_app/screens/splashScreen.dart';
import 'package:ecommerce_app/screens/testScreen.dart';

import 'screens/cartScreen.dart';
import 'screens/orderScreen.dart';
import 'screens/productScreen.dart';
import 'screens/searchScreen.dart';

final routes = {
  ProductScreen.routeName: (context) => ProductScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  OrderScreen.routeName: (context) => OrderScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  TestScreen.routeName: (context) => TestScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
};

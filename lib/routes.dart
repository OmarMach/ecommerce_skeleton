import 'package:ecommerce_app/screens/categoryProductsScreen.dart';

import 'screens/favoritesScreen.dart';

import 'screens/homeScreen.dart';
import 'screens/loginScreen.dart';
import 'screens/registerScreen.dart';
import 'screens/splashScreen.dart';
import 'screens/testScreen.dart';
import 'screens/cartScreen.dart';
import 'screens/orderScreen.dart';
import 'screens/productScreen.dart';
import 'screens/searchScreen.dart';

final routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  ProductScreen.routeName: (context) => ProductScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  OrderScreen.routeName: (context) => OrderScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  TestScreen.routeName: (context) => TestScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  FavoritesScreen.routeName: (context) => FavoritesScreen(),
  CategoryProductsScreen.routeName: (context) => CategoryProductsScreen(),
};

import 'package:ecommerce_app/screens/AddAddressScreen.dart';
import 'package:ecommerce_app/screens/addressesScreen.dart';
import 'package:ecommerce_app/screens/categoryProductsScreen.dart';
import 'package:ecommerce_app/screens/editAccountDetails.dart';
import 'package:ecommerce_app/screens/orderDetailsScreen.dart';
import 'package:ecommerce_app/screens/ordersScreen.dart';
import 'package:ecommerce_app/screens/profileScreen.dart';

import 'screens/favoritesScreen.dart';

import 'screens/homeScreen.dart';
import 'screens/loginScreen.dart';
import 'screens/registerScreen.dart';
import 'screens/splashScreen.dart';
import 'screens/testScreen.dart';
import 'screens/cartScreen.dart';
import 'screens/checkoutScreen.dart';
import 'screens/productScreen.dart';
import 'screens/searchScreen.dart';

final routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  ProductScreen.routeName: (context) => ProductScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  AddressesScreen.routeName: (context) => AddressesScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  CheckoutScreen.routeName: (context) => CheckoutScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  TestScreen.routeName: (context) => TestScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  FavoritesScreen.routeName: (context) => FavoritesScreen(),
  CategoryProductsScreen.routeName: (context) => CategoryProductsScreen(),
  EditAccountDetails.routeName: (context) => EditAccountDetails(),
  AddAddressScreen.routeName: (context) => AddAddressScreen(),
  OrdersScreen.routeName: (context) => OrdersScreen(),
  OrderDetailsScreen.routeName: (context) => OrderDetailsScreen(),
};

import 'package:ecommerce_app/screens/cartScreen.dart';
import 'package:ecommerce_app/screens/homeScreen.dart';
import 'package:ecommerce_app/screens/profileScreen.dart';
import 'package:ecommerce_app/screens/searchScreen.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:flutter/material.dart';

import 'favoritesScreen.dart';

class WrapperScreen extends StatefulWidget {
  static const routeName = '/wrapper';
  @override
  WrapperScreenState createState() => WrapperScreenState();
}

class WrapperScreenState extends State<WrapperScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CartScreen(),
    SearchScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerMenuWidget(),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wish list',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

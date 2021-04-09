import 'package:ecommerce_app/screens/cartScreen.dart';
import 'package:ecommerce_app/screens/homeScreen.dart';
import 'package:ecommerce_app/screens/searchScreen.dart';
import 'package:ecommerce_app/screens/testScreen.dart';
import 'package:flutter/material.dart';

class WrapperScreen extends StatefulWidget {
  @override
  WrapperScreenState createState() => WrapperScreenState();
}

class WrapperScreenState extends State<WrapperScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CartScreen(),
    SearchScreen(),
    TestScreen(),
    TestScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
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
            label: 'Favorites',
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

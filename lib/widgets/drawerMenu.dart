import 'package:ecommerce_app/screens/favoritesScreen.dart';
import 'package:ecommerce_app/screens/homeScreen.dart';
import 'package:ecommerce_app/screens/orderScreen.dart';
import 'package:ecommerce_app/screens/testScreen.dart';
import 'package:flutter/material.dart';

class DrawerMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Image.asset(
                'assets/images/Logo.png',
                width: size.width / 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Browse",
                style: textTheme.caption,
              ),
            ),
            Divider(),
            DrawerMenuItem(
              icon: Icons.home,
              label: 'Home',
              onTap: () {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              },
            ),
            DrawerMenuItem(
              icon: Icons.favorite,
              label: 'My Wishlist',
              onTap: () {
                Navigator.of(context).pushNamed(FavoritesScreen.routeName);
              },
            ),
            DrawerMenuItem(
              icon: Icons.person,
              label: 'My Account',
              onTap: () {
                Navigator.of(context).pushNamed(TestScreen.routeName);
              },
            ),
            DrawerMenuItem(
              icon: Icons.payment,
              label: 'Checkout',
              onTap: () {
                Navigator.of(context).pushNamed(OrderScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerMenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;
  const DrawerMenuItem({
    Key key,
    @required this.label,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

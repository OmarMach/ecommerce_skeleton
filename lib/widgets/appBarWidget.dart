import 'package:ecommerce_app/screens/cartScreen.dart';
import 'package:ecommerce_app/screens/searchScreen.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/Logo.png',
          width: size.width * .3,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(SearchScreen.routeName);
          },
          icon: Icon(
            Icons.search,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
          icon: Icon(
            Icons.shopping_bag_outlined,
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

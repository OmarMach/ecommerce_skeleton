import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/screens/cartScreen.dart';
import 'package:ecommerce_app/screens/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            if (ModalRoute.of(context).settings.name != SearchScreen.routeName)
              Navigator.of(context).pushNamed(SearchScreen.routeName);
          },
          icon: Icon(
            Icons.search,
          ),
        ),
        IconButton(
          onPressed: () {
            if (ModalRoute.of(context).settings.name != CartScreen.routeName)
              Navigator.of(context).pushNamed(CartScreen.routeName);
          },
          icon: Consumer<CartProvider>(
            child: Icon(
              Icons.shopping_bag_outlined,
            ),
            builder: (context, cartProvider, child) => Stack(
              alignment: Alignment.center,
              children: [
                child,
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    // color: Theme.of(context).accentColor,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.red,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      cartProvider.count.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

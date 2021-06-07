import 'package:ecommerce_app/providers/favoritesProvider.dart';
import 'package:ecommerce_app/screens/searchScreen.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:ecommerce_app/widgets/drawerMenu.dart';
import 'package:ecommerce_app/widgets/favoritesGridList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favs';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerMenuWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Consumer<FavoritesProvider>(
                builder: (context, favoritesProvider, _) {
                  return favoritesProvider.favorites.isNotEmpty
                      ? FavoritesGridList(
                          favoritesList: favoritesProvider.favorites,
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_border_rounded,
                                size: size.width / 3,
                              ),
                              Text(
                                "Your wish list is empty",
                                style: textTheme.subtitle1,
                              ),
                              verticalSeparator,
                              Text(
                                "You can add items to your whishlist, through the ❤️ icon from any product details.",
                                style: textTheme.caption,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

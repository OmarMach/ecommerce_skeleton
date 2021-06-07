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
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            repeat: ImageRepeat.repeat,
            image: AssetImage('assets/images/background.jpg'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Consumer<FavoritesProvider>(
                builder: (context, favoritesProvider, _) {
                  if (favoritesProvider.favorites.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "My Favorites",
                                style: textTheme.headline4,
                              ),
                            ),
                            Text(
                              "This list will help you track your favorite products.",
                              style: textTheme.caption,
                            ),
                            verticalSeparator,
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      primary: Colors.redAccent,
                                      side: BorderSide(
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    onPressed: () {
                                      favoritesProvider.clearFavorites();
                                    },
                                    child: Text("Clear Favorites"),
                                  ),
                                ),
                              ],
                            ),
                            FavoritesGridList(
                              favoritesList: favoritesProvider.favorites,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
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
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

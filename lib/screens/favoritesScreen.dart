import 'package:ecommerce_app/providers/favoritesProvider.dart';
import 'package:ecommerce_app/widgets/favoritesGridList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favs';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wish list",
                style: textTheme.headline4,
              ),
              Text(
                "This list helps you to easily find saved items..",
                style: textTheme.bodyText2,
              ),
            ],
          ),
        ),
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
                            Text(
                              "Your wish list is empty..",
                              style: textTheme.subtitle1,
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ),
      ],
    );
  }
}

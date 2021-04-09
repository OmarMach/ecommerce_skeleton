import 'package:ecommerce_app/widgets/FavoriteProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';

class FavoritesGridList extends StatelessWidget {
  final List<WooProduct> favoritesList;
  FavoritesGridList({
    Key key,
    @required this.favoritesList,
  }) : super(key: key);

  final sliverGridDelegateWithFixedCrossAxisCount =
      SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.5,
    mainAxisSpacing: 20,
    crossAxisSpacing: 20,
  );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: favoritesList.length,
      gridDelegate: sliverGridDelegateWithFixedCrossAxisCount,
      itemBuilder: (context, index) => FavoriteProductWidget(
        product: favoritesList.elementAt(index),
      ),
    );
  }
}

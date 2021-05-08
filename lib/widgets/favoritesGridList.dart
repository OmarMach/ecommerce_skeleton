import 'package:ecommerce_app/widgets/FavoriteProductWidget.dart';
import 'package:ecommerce_app/widgets/productWidget.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';

class FavoritesGridList extends StatelessWidget {
  final List<WooProduct> favoritesList;
  FavoritesGridList({
    Key key,
    @required this.favoritesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sliverGridDelegateWithFixedCrossAxisCount =
        SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: size.width >= 1000
          ? 5
          : size.width >= 600
              ? 3
              : 2,
      childAspectRatio: 0.5,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
    );
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: favoritesList.length,
      gridDelegate: sliverGridDelegateWithFixedCrossAxisCount,
      itemBuilder: (context, index) => ProductWidget(
        product: favoritesList.elementAt(index),
      ),
    );
  }
}

import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/productScreen.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductScreen.routeName,
            arguments: product.id,
          );
        },
        child: Image.network(
          product.imageURl,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        subtitle: Text(product.description),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart),
        ),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

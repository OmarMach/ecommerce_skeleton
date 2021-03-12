import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/productScreen.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  final Product product;

  const ProductWidget({Key key, @required this.product}) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductScreen.routeName,
            arguments: widget.product.id,
          );
        },
        child: Image.network(
          widget.product.imageURl,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        subtitle: Text(widget.product.description),
        leading: IconButton(
          icon: Icon(
            widget.product.isFavorite ? Icons.favorite : Icons.favorite_outline,
          ),
          onPressed: () {
            setState(() {
              widget.product.toggleFavorite();
            });
          },
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart),
        ),
        title: Text(
          widget.product.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/favoritesProvider.dart';
import 'package:ecommerce_app/screens/productScreen.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';

class FavoriteProductWidget extends StatefulWidget {
  final WooProduct product;

  const FavoriteProductWidget({Key key, @required this.product})
      : super(key: key);

  @override
  _FavoriteProductWidgetState createState() => _FavoriteProductWidgetState();
}

class _FavoriteProductWidgetState extends State<FavoriteProductWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Item removed from wish list.."),
                ),
              );
              Provider.of<FavoritesProvider>(
                context,
                listen: false,
              ).deleteFromFavorites(widget.product);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.close),
                  Text("Remove"),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: ClipRRect(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ProductScreen.routeName,
                  arguments: widget.product,
                );
              },
              child: Image.network(
                widget.product.images[0].src,
                fit: BoxFit.fill,
                width: size.width,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.product.price + " Tnd",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: textTheme.subtitle1.copyWith(
                      color: Colors.green,
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.product.stockStatus != 'instock'
                        ? null
                        : () {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Item Added to the cart.."),
                              ),
                            );
                            Provider.of<CartProvider>(
                              context,
                              listen: false,
                            ).addCartItem(widget.product);
                          },
                    child: Text(
                      widget.product.stockStatus != 'instock'
                          ? "Out of stock"
                          : "Add to cart",
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade800,
                    ),
                  ),
                ),
                verticalSeparator,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        ProductScreen.routeName,
                        arguments: widget.product,
                      );
                    },
                    child: Text("View"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade800,
                    ),
                  ),
                ),
                verticalSeparator,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

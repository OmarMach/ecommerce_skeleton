import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/favoritesProvider.dart';
import 'package:ecommerce_app/screens/productScreen.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';

class ProductWidget extends StatefulWidget {
  final WooProduct product;

  const ProductWidget({Key key, @required this.product}) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: size.height / 2.5,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
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
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.product.name,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Text(
                          widget.product.price + " Tnd",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: textTheme.subtitle1.copyWith(
                            color: Colors.green,
                          ),
                        ),
                        Flexible(
                          child: ElevatedButton(
                            onPressed: widget.product.stockStatus != 'instock'
                                ? () {
                                    Navigator.of(context).pushNamed(
                                      ProductScreen.routeName,
                                      arguments: widget.product,
                                    );
                                  }
                                : () {
                                    ScaffoldMessenger.of(context)
                                        .removeCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text("Item Added to the cart.."),
                                      ),
                                    );
                                    Provider.of<CartProvider>(
                                      context,
                                      listen: false,
                                    ).addCartItem(widget.product);
                                  },
                            child: Text(
                              widget.product.stockStatus != 'instock'
                                  ? "Read More"
                                  : "Add to cart",
                            ),
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
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: Center(
                    child: Consumer<FavoritesProvider>(
                      builder: (context, favoritesProvider, _) {
                        // Getting the products state in the wishlist.
                        bool alreadyExists = favoritesProvider
                            .checkIfAlreadyExists(widget.product);

                        return IconButton(
                          splashRadius: 10,
                          icon: Icon(
                            alreadyExists
                                ? Icons.check
                                : Icons.favorite_outline,
                            color: alreadyExists
                                ? Colors.red.shade800
                                : Colors.green.shade700,
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            if (alreadyExists) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Item removed to the favorites.."),
                                ),
                              );
                              favoritesProvider
                                  .deleteFromFavorites(widget.product);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Item Added to the favorites.."),
                                ),
                              );
                              favoritesProvider.addToFavorites(widget.product);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

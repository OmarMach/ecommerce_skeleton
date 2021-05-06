import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/favoritesProvider.dart';
import 'package:ecommerce_app/screens/favoritesScreen.dart';
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
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
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
                          if (widget.product.stockStatus != 'instock')
                            Positioned(
                              bottom: 0,
                              child: Row(
                                children: [
                                  Chip(
                                    label: Text(
                                      "Out of stock",
                                      style: TextStyle(
                                        color: Colors.redAccent.shade200,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
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
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: Text(
                                widget.product.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(5),
                          child: Center(
                            child: Text(
                              widget.product.price + " TND",
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: textTheme.subtitle1.copyWith(
                                color: Colors.green,
                              ),
                            ),
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
                                    final scaffoldMessenger =
                                        ScaffoldMessenger.of(context);

                                    // Clearing all the currently displayed snackbars.
                                    scaffoldMessenger.removeCurrentSnackBar();
                                    final cartProvider =
                                        Provider.of<CartProvider>(context,
                                            listen: false);
                                    final cartItem = cartProvider
                                        .getCartItemById(widget.product.id);
                                    if (cartItem == null) {
                                      // Creating a snack bar showing delete message.
                                      final incrementSnackBar = SnackBar(
                                        content: Text('Item added from cart..'),
                                      );
                                      // Showing the snackbar.
                                      scaffoldMessenger
                                          .showSnackBar(incrementSnackBar);
                                      cartProvider.addCartItem(widget.product);
                                    } else if (cartItem.quantity <
                                        cartItem.product.stockQuantity) {
                                      // Creating a snack bar showing delete message.
                                      final incrementSnackBar = SnackBar(
                                        content: Text('Item added from cart..'),
                                      );
                                      // Showing the snackbar.
                                      scaffoldMessenger
                                          .showSnackBar(incrementSnackBar);
                                      cartProvider
                                          .incrementCartItemQuantity(cartItem);
                                    } else {
                                      // Creating a snack bar showing delete message.
                                      final cannotIncrementSnackBar = SnackBar(
                                        content: Text(
                                          'Can\'t add anymore of this product.',
                                        ),
                                      );
                                      // Showing the snackbar.
                                      scaffoldMessenger.showSnackBar(
                                          cannotIncrementSnackBar);
                                    }
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
                                      Text("Item removed to the Wish list.."),
                                  action: SnackBarAction(
                                    label: "View Wish List",
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(FavoritesScreen.routeName);
                                    },
                                  ),
                                ),
                              );
                              favoritesProvider
                                  .deleteFromFavorites(widget.product);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Item Added to the Wish list.."),
                                  action: SnackBarAction(
                                    label: "View Wish List",
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(FavoritesScreen.routeName);
                                    },
                                  ),
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

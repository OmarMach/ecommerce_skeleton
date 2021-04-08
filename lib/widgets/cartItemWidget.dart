import 'package:ecommerce_app/models/cartItem.dart';
import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    @required this.cartItem,
    Key key,
  }) : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    final size = MediaQuery.of(context).size;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            Image.network(
              cartItem.product.images[0].src,
              fit: BoxFit.cover,
              height: size.width / 3,
              width: size.width / 4,
            ),
            Expanded(
              child: Container(
                color: Colors.grey.shade800,
                height: size.width / 3,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              cartItem.product.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Divider(),
                            Text("Price : " + cartItem.product.price + " Tnd"),
                            Divider(),
                            Text("Quantity : x" + cartItem.quantity.toString()),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Flexible(
                          child: ClipRRect(
                            child: Material(
                              color: Colors.grey,
                              child: InkWell(
                                splashColor: Colors.red.shade100,
                                child: SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: Icon(
                                    Icons.close,
                                  ),
                                ),
                                onTap: () {
                                  // Clearing all the currently displayed snackbars.

                                  scaffoldMessenger.removeCurrentSnackBar();
                                  // Creating a snack bar showing delete message.
                                  final deleteSnackbar = SnackBar(
                                    content: Text('Item deleted from cart..'),
                                  );
                                  // Showing the snackbar.
                                  scaffoldMessenger
                                      .showSnackBar(deleteSnackbar);
                                  cartProvider.deleteCartItem(cartItem);
                                },
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: ClipRRect(
                            child: Material(
                              color: Colors.grey,
                              child: InkWell(
                                splashColor: Colors.teal,
                                child: SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: Icon(
                                      Icons.add,
                                    )),
                                onTap: () {
                                  // Clearing all the currently displayed snackbars.

                                  scaffoldMessenger.removeCurrentSnackBar();
                                  // Creating a snack bar showing delete message.
                                  final incrementSnackBar = SnackBar(
                                    content: Text('Item added from cart..'),
                                  );
                                  // Showing the snackbar.
                                  scaffoldMessenger
                                      .showSnackBar(incrementSnackBar);
                                  cartProvider
                                      .incrementCartItemQuantity(cartItem);
                                },
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: ClipRRect(
                            child: Material(
                              color: Colors.grey, // button color
                              child: InkWell(
                                splashColor: Colors.teal, // inkwell color
                                child: SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: Icon(Icons.remove)),
                                onTap: () {
                                  // Clearing all the currently displayed snackbars.

                                  scaffoldMessenger.removeCurrentSnackBar();
                                  // Creating a snack bar showing delete message.
                                  final decrementSnackBar = SnackBar(
                                    content: Text('Item removed from cart..'),
                                  );
                                  // Showing the snackbar.
                                  scaffoldMessenger
                                      .showSnackBar(decrementSnackBar);
                                  cartProvider
                                      .decrementCartItemQuantity(cartItem);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

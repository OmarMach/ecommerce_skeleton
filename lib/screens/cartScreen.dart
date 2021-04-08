import 'package:ecommerce_app/models/cartItem.dart';
import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/stepWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: cartProvider.items.isNotEmpty
          ? SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Shopping Cart",
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    StepWidget(step: 1),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Cart Items",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Divider(),
                    Consumer<CartProvider>(
                      builder: (context, cart, child) => ListView.builder(
                        itemCount: cart.items.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CartItemWidget(
                            cartItem: cart.items.values.elementAt(index),
                          );
                        },
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Total",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    CartTotalWidget(
                      cartProvider: cartProvider,
                    ),
                    Divider(),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamed(OrderScreen.routeName);
                        cartProvider.addCartItem(productProvider.items[0]);
                      },
                      child: Text("Order"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade800,
                      ),
                    ),
                  ]),
            ))
          : Center(
              child: Text("There are no items In the cart."),
            ),
    );
  }
}

class CartTotalWidget extends StatelessWidget {
  const CartTotalWidget({
    Key key,
    @required this.cartProvider,
  }) : super(key: key);
  final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.grey.shade800,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cartProvider.total.toString(),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    cartProvider.total.toString() + "tnd",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    "125.999 Tnd",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    this.cartItem,
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
                            Text("Price : " + cartItem.product.price + " Tnd"),
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

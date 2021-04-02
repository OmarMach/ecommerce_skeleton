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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.grey.shade900,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cartItem.product.name ?? " ",
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: size.height / 40,
                    child: Icon(Icons.close, size: size.height / 40),
                    backgroundColor: Colors.grey.shade800,
                  ),
                  horizontalSeparator,
                  horizontalSeparator,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      cartItem.product.images[0].src,
                      height: size.width / 6,
                      width: size.width / 6,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      cartItem.product.price,
                                    ),
                                    Text(
                                      cartItem.quantity.toString(),
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          final snackBar = SnackBar(
                                            content:
                                                Text('Quantity incremented.'),
                                            action: SnackBarAction(
                                              label: 'Undo',
                                              onPressed: () {
                                                cartProvider
                                                    .decrementCartItemQuantity(
                                                  cartItem,
                                                );
                                              },
                                            ),
                                          );
                                          // Deleting the current snackBar to display the new one
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          cartProvider
                                              .incrementCartItemQuantity(
                                                  cartItem);
                                        },
                                        child: CircleAvatar(
                                          child: Icon(Icons.add),
                                          backgroundColor: Colors.grey.shade800,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          final snackBar = SnackBar(
                                            content:
                                                Text('Quantity decremented.'),
                                            action: SnackBarAction(
                                              label: 'Undo',
                                              onPressed: () {
                                                cartProvider
                                                    .incrementCartItemQuantity(
                                                  cartItem,
                                                );
                                              },
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          cartProvider
                                              .decrementCartItemQuantity(
                                                  cartItem);
                                        },
                                        child: CircleAvatar(
                                          child: Icon(Icons.remove),
                                          backgroundColor: Colors.grey.shade800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:ecommerce_app/widgets/cartItemWidget.dart';
import 'package:ecommerce_app/widgets/stepWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart';
import 'orderScreen.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          return cartProvider.items.isNotEmpty
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildAppBarSpacer(size),
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
                        ListView.builder(
                          itemCount: cartProvider.items.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CartItemWidget(
                              cartItem:
                                  cartProvider.items.values.elementAt(index),
                            );
                          },
                        ),
                        Divider(),
                        CartTotalWidget(
                          cartProvider: cartProvider,
                        ),
                        Divider(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(OrderScreen.routeName);
                          },
                          child: Text("Order"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    "There are no items In the cart.",
                    style: textTheme.subtitle1,
                  ),
                );
        },
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
                    "Total",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    cartProvider.total.toString() + " Tnd",
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

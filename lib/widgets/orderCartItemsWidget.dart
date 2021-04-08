import 'package:ecommerce_app/models/cartItem.dart';
import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderCartItemsWidget extends StatelessWidget {
  const OrderCartItemsWidget({
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

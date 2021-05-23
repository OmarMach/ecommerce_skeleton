import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/providers/userProvider.dart';
import 'package:ecommerce_app/screens/orderDetailsScreen.dart';
import 'package:ecommerce_app/screens/searchScreen.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'cartScreen.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBarWidget(),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Your Orders",
                    style: textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "This list will display all the orders you made with this account.",
                      textAlign: TextAlign.justify,
                      style: textTheme.caption,
                    ),
                  ),
                  ListView.separated(
                    itemCount: userProvider.userOrders.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OrderListItem(
                          order: userProvider.userOrders.elementAt(index),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.yellow,
                      );
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class OrderListItem extends StatelessWidget {
  const OrderListItem({
    Key key,
    @required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OrderRowItem(
            label: 'Order ID',
            value: '#${order.id}',
          ),
          OrderRowItem(
            label: 'Date',
            value:
                '${DateTime.tryParse(order.date).day}/${DateTime.tryParse(order.date).month}/${DateTime.tryParse(order.date).year}  ${DateTime.tryParse(order.date).hour}:${DateTime.tryParse(order.date).second}',
          ),
          OrderRowItem(
            label: 'Shipping Method',
            value: '${order.shipping.keys.first}',
          ),
          OrderRowItem(
            label: 'Shipping Price',
            value: '${order.shipping.values.first}',
          ),
          OrderRowItem(
            label: 'Status',
            value: '${order.status}',
          ),
          OrderRowItem(
            label: 'Total',
            value: '${order.total}',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  OrderDetailsScreen.routeName,
                  arguments: order,
                );
              },
              child: Text("View Order"),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade800,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: ElevatedButton(
              onPressed: () {},
              child: Text("View Invoice"),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderRowItem extends StatelessWidget {
  const OrderRowItem({
    Key key,
    @required this.label,
    @required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value.capitalize(),
            style: TextStyle(
              color: (value == 'processing' ||
                      value == 'pending' ||
                      value == 'on-hold')
                  ? Colors.yellow
                  : (value == 'cancelled' || value == 'failed')
                      ? Colors.red
                      : value == 'completed'
                          ? Colors.green
                          : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class NoOrderWidget extends StatelessWidget {
  const NoOrderWidget({
    Key key,
    @required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FaIcon(
              FontAwesomeIcons.clipboardList,
              size: 80,
            ),
          ),
          Text(
            "Orders",
            style: textTheme.headline5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Your order history is empty, to add orders you can add products to your cart.",
              textAlign: TextAlign.justify,
              style: textTheme.caption,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SearchScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Text("Browse Products"),
              ),
              horizontalSeparator,
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                child: Text("Open Cart"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

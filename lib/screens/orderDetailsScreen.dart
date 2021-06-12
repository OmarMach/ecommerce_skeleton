import 'package:ecommerce_app/models/address.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:ecommerce_app/widgets/appBarWidget.dart';
import 'package:flutter/material.dart';

import 'addressesScreen.dart';

class OrderDetailsScreen extends StatelessWidget {
  static const routeName = '/order-detail';
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final order = ModalRoute.of(context).settings.arguments as Order;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            repeat: ImageRepeat.repeat,
            image: AssetImage('assets/images/background.jpg'),
          ),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text(
                        "Order details",
                        style: textTheme.subtitle1,
                      ),
                      Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                ),
                verticalSeparator,
                OrderDetailsWidget(order: order),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text(
                        "Products",
                        style: textTheme.subtitle1,
                      ),
                      Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                ),
                OrderItemsListWidget(orderItems: order.products),
                verticalSeparator,
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text(
                        "Billing address",
                        style: textTheme.subtitle1,
                      ),
                      Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                ),
                OrderAddressWidget(address: order.address),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade800,
                          ),
                          onPressed: () {},
                          child: Text("View Invoice"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderAddressWidget extends StatelessWidget {
  const OrderAddressWidget({
    Key key,
    @required this.address,
  }) : super(key: key);

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AddressItemWidget(
              label: 'Full name',
              value: '${address.firstName} ${address.lastName}',
            ),
            AddressItemWidget(
              label: 'Email Address',
              value: '${address.email}',
            ),
            AddressItemWidget(
              label: 'Location',
              value: '${address.city} ${address.country} ${address.state}',
            ),
            AddressItemWidget(
              label: 'Zip code',
              value: '${address.postcode}',
            ),
          ],
        ),
      ),
    );
  }
}

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    Key key,
    @required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping"),
                  Text("${order.shipping.keys.first}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Payment method"),
                  Text("Cash on delivery"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping Price"),
                  Text("${order.shipping.values.first} Tnd"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total"),
                  Text("${order.total} Tnd "),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItemsListWidget extends StatelessWidget {
  const OrderItemsListWidget({
    Key key,
    @required this.orderItems,
  }) : super(key: key);

  final List<OrderItem> orderItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListView.builder(
            itemCount: orderItems.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = orderItems.elementAt(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.shade900,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${item?.name}'),
                              Text('Quantity : x${item?.quantity}'),
                            ],
                          ),
                          Text('${item?.price} Tnd'),
                        ],
                      ),
                      Divider(),
                      Text("Total : ${item?.total} Tnd")
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}

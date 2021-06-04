import 'package:ecommerce_app/models/address.dart';
import 'package:flutter/foundation.dart';

class Order {
  final String id;
  final String total;
  final String date;
  final String status;
  final Address address;
  final List<OrderItem> products = [];
  final Map<String, String> shipping = {};

  Order({
    @required this.date,
    @required this.status,
    @required this.id,
    @required this.total,
    @required this.address,
  });

  factory Order.fromJSON(Map map) {
    try {
      final Order order = Order(
        date: map['date_created'].toString(),
        status: map['status'].toString(),
        id: map['id'].toString(),
        total: map['total'].toString(),
        address: Address.fromJSON(map['billing']),
      );

      final recievedProducts = map['line_items'] as List;
      recievedProducts.forEach((element) {
        final orderItem = OrderItem.fromJSON(element);
        order.products.add(orderItem);
      });

      if (map['shipping_lines'] != null &&
          (map['shipping_lines'] as List).isNotEmpty) {
        if (map['shipping_lines'][0] != null) {
          if (map['shipping_lines'][0]['method_title'] != null) {
            order.shipping.putIfAbsent(
              map['shipping_lines'][0]['method_title'].toString(),
              () => map['shipping_lines'][0]['total'].toString(),
            );
          }
        }
      }

      return order;
    } catch (e) {
      print("Error While getting the orders.");
      throw (e);
    }
  }
}

class OrderItem {
  final String name;
  final String price;
  final String quantity;
  final String id;
  final String total;

  OrderItem({
    @required this.name,
    @required this.price,
    @required this.quantity,
    @required this.id,
    @required this.total,
  });

  factory OrderItem.fromJSON(Map map) {
    try {
      final orderItem = OrderItem(
        id: map['id'].toString(),
        name: map['name'].toString(),
        price: map['price'].toString(),
        total: map['total'].toString(),
        quantity: map['quantity'].toString(),
      );

      return orderItem;
    } catch (e) {
      print(e);
    }
  }
}

import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = '/product';

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context).settings.arguments as Product;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            product.imageURl,
            height: size.height / 3,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(product.title),
          ),
        ],
      ),
    );
  }
}

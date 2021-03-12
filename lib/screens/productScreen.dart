import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = '/product';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final product =
        Provider.of<ProductProvider>(context, listen: false).getProductById(id);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            product.imageURl,
            fit: BoxFit.cover,
            height: size.height / 2,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            product.description,
            textAlign: TextAlign.center,
          ),
          Text(
            "Price : ${product.price} \$ ",
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_basket_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.favorite_outline),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

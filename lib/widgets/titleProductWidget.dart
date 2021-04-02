import 'package:ecommerce_app/screens/productScreen.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';

class TitleProductWidget extends StatefulWidget {
  final WooProduct product;

  const TitleProductWidget({Key key, @required this.product}) : super(key: key);

  @override
  _TitleProductWidgetState createState() => _TitleProductWidgetState();
}

class _TitleProductWidgetState extends State<TitleProductWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductScreen.routeName,
                arguments: widget.product.id,
              );
            },
            child: Image.network(
              widget.product.images[0].src,
              fit: BoxFit.cover,
              width: size.width,
              height: size.height / 5.5,
            ),
          ),
          Container(
            color: Colors.black87,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.product.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    widget.product.price + " tnd",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Add to cart"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade800,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      ProductScreen.routeName,
                      arguments: widget.product.id,
                    );
                  },
                  child: Text("View"),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.grey,
                    // backgroundColor: Colors.grey.shade900,
                    side: BorderSide(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

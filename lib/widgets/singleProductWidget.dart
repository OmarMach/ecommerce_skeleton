import 'package:ecommerce_app/screens/productScreen.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';

class SingleProductWidget extends StatefulWidget {
  final WooProduct product;

  const SingleProductWidget({Key key, @required this.product})
      : super(key: key);

  @override
  _SingleProductWidgetState createState() => _SingleProductWidgetState();
}

class _SingleProductWidgetState extends State<SingleProductWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductScreen.routeName,
              arguments: widget.product,
            );
          },
          child: Image.network(
            widget.product.images[0].src ??
                'https://image.shutterstock.com/image-vector/ui-image-placeholder-wireframes-apps-260nw-1037719204.jpg',
            fit: BoxFit.fill,
            width: size.width / 2,
            height: size.height / 5,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.product.price + " TND",
                      textAlign: TextAlign.center,
                      style: textTheme.subtitle1.copyWith(
                        color: Colors.green,
                      ),
                    ),
                    if (widget.product != null &&
                        widget.product.stockQuantity < 0)
                      Row(
                        children: [
                          Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                          Text(
                            'Out of stock',
                            style: textTheme.caption.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ProductScreen.routeName,
                    arguments: widget.product,
                  );
                },
                child: Text("Add to cart"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade800,
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ProductScreen.routeName,
                    arguments: widget.product,
                  );
                },
                child: Text("View"),
                style: OutlinedButton.styleFrom(
                  primary: Colors.grey,
                  side: BorderSide(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

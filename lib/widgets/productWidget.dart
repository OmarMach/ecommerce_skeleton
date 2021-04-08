import 'package:ecommerce_app/screens/productScreen.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';

class ProductWidget extends StatefulWidget {
  final WooProduct product;

  const ProductWidget({Key key, @required this.product}) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: size.height / 2.5,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      widget.product.images[0].src,
                      fit: BoxFit.fill,
                      width: size.width,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.product.price + " Tnd",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: textTheme.subtitle1.copyWith(
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: widget.product.stockStatus != 'instock'
                                ? null
                                : () {},
                            child: Text(
                              widget.product.stockStatus != 'instock'
                                  ? "Out of stock"
                                  : "Add to cart",
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        verticalSeparator,
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                ProductScreen.routeName,
                                arguments: widget.product,
                              );
                            },
                            child: Text("View"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        verticalSeparator,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: Center(
                    child: IconButton(
                      splashRadius: 10,
                      icon: Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

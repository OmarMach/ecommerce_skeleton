import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/screens/productScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:woocommerce/models/products.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);

    return Container(
      height: size.height / 2,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          disableCenter: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          initialPage: 0,
        ),
        items: [
          ...productsProvider.items
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselListViewItem(
                    product: e,
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class CarouselListViewItem extends StatelessWidget {
  final WooProduct product;
  const CarouselListViewItem({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Flexible(
          flex: 3,
          child: Image.network(
            product.images[0].src,
            height: size.height / 2,
            width: size.height / 2,
            fit: BoxFit.fill,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.black87,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade800,
                      ),
                      child: Text("Add to cart"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(ProductScreen.routeName,
                            arguments: product);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade800,
                      ),
                      child: Text("View"),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

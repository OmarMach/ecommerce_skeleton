import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:woocommerce/models/products.dart';

class ComingSoonCarouselWidget extends StatelessWidget {
  const ComingSoonCarouselWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);

    return Container(
      height: size.height / 4.5,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          disableCenter: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          initialPage: 0,
          viewportFraction: size.width >= 1200
              ? 1 / 4
              : size.width >= 600
                  ? 1 / 3
                  : 1 / 2,
        ),
        items: [
          ...productsProvider.bestSellingProducts
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
    // Visual Getters
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.width,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(
            product.images[0].src,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';

class ProductMiniatureImageList extends StatelessWidget {
  final List<WooProductImage> images;

  const ProductMiniatureImageList({Key key, @required this.images})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: images.elementAt(index).src,
              height: 35,
              filterQuality: FilterQuality.none,
              width: 35,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

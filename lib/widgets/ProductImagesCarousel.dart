import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductImagesCarousel extends StatelessWidget {
  final List items;

  const ProductImagesCarousel({Key key, @required this.items})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CarouselSlider.builder(
      itemCount: items.length,
      options: CarouselOptions(
        autoPlay: false,
        // disableCenter: true,
        enableInfiniteScroll: false,
        height: size.height / 2,

        enlargeStrategy: CenterPageEnlargeStrategy.height,
        initialPage: 0,
        viewportFraction: 1,
      ),
      itemBuilder: (context, index, _) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: items.elementAt(index).src,
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(),
                ),
                fit: BoxFit.fill,
                height: size.height / 2,
                width: size.width,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 20,
            child: Chip(
              label: Text("${index + 1} / ${items.length}"),
            ),
          )
        ],
      ),
    );
  }
}

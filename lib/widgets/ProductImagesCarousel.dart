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
        
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        initialPage: 0,
        viewportFraction: 1,
      ),
      itemBuilder: (context, index, _) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(
          items.elementAt(index).src,
          fit: BoxFit.cover,
          height: size.height / 2,
          width: size.width,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';

class ProductImagesNavigatorWidget extends StatefulWidget {
  final WooProduct product;

  const ProductImagesNavigatorWidget({Key key, this.product}) : super(key: key);
  @override
  _ProductImagesNavigatorWidgetState createState() =>
      _ProductImagesNavigatorWidgetState();
}

class _ProductImagesNavigatorWidgetState
    extends State<ProductImagesNavigatorWidget> {
  int currentImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.network(
          widget.product.images[currentImageIndex].src,
          fit: BoxFit.cover,
          height: size.height / 2,
          width: size.width,
        ),
        // Only show the controls if the products have more than 1 image.
        if (widget.product.images.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentImageIndex > 0)
                Material(
                  color: Colors.black.withAlpha(150),
                  child: InkWell(
                    child: SizedBox(
                      height: size.height / 2,
                      width: 35,
                      child: Icon(
                        Icons.keyboard_arrow_left_outlined,
                      ),
                    ),
                    onTap: () {
                      if (currentImageIndex > 0)
                        setState(() {
                          currentImageIndex--;
                        });
                    },
                  ),
                ),
              // This box Prevents from the buttons changing their locations
              Expanded(
                child: SizedBox(),
              ),
              if (currentImageIndex < widget.product.images.length - 1)
                Material(
                  color: Colors.black.withAlpha(150),
                  child: InkWell(
                    child: SizedBox(
                      height: size.height / 2,
                      width: 35,
                      child: Icon(
                        Icons.keyboard_arrow_right_outlined,
                      ),
                    ),
                    onTap: () {
                      if (currentImageIndex < widget.product.images.length)
                        setState(() {
                          currentImageIndex++;
                        });
                    },
                  ),
                ),
            ],
          )
      ],
    );
  }
}

import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/productProvider.dart';
import 'package:ecommerce_app/screens/cartScreen.dart';
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
      height: size.height / 2.5,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          disableCenter: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          initialPage: 0,
          viewportFraction: size.width >= 1200
              ? 1 / 3
              : size.width >= 600
                  ? 1 / 2
                  : 1,
        ),
        items: [
          ...productsProvider.carouselItems
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
      child: Column(
        children: [
          // This prevents the container below from taking all the image.
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.grey.shade700.withAlpha(230),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      product.price + " TND",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.green,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          onPressed: product.stockStatus != 'instock'
                              ? null
                              : () {
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Item Added to the cart.."),
                                      action: SnackBarAction(
                                        label: "View Cart",
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed(CartScreen.routeName);
                                        },
                                      ),
                                    ),
                                  );
                                  Provider.of<CartProvider>(
                                    context,
                                    listen: false,
                                  ).addCartItem(product);
                                },
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            side: BorderSide(
                              color: Colors.redAccent,
                            ),
                          ),
                          child: Text("Add to cart"),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              ProductScreen.routeName,
                              arguments: product,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            side: BorderSide(
                              color: Colors.redAccent,
                            ),
                          ),
                          child: Text("View"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
